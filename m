Return-Path: <linux-kernel+bounces-134015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486789AC22
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DA91F21505
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9A4176C;
	Sat,  6 Apr 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEGiyEUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793940BE6;
	Sat,  6 Apr 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422067; cv=none; b=Iz/KlIVtNM4Z/MitmtLxaSoS4Whc0wByhdU3/sPmn2KpZJITPgeGycb7EVRTeZj0km29EKYbuMf0Q0ZcDkwrrGJGHPJPf6pqmFWC/U+pHn5PKoidQVs7boiXbZBKGbCJR97WKPxhsbYfCVpKehttNqS4FkTTPwd41XcZzEUm4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422067; c=relaxed/simple;
	bh=MKSYUuL5EWHfVs1stO0tc254Y3E6+JVTDm0nqhyRRPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYjcFXAgl1rpunlexpbznNdw9VV/UUVq62uQiCmbINepDPFJHHooaK5BNCVXDkpX4AYb5lu4e8evUaHmZ7BVr+ih4KHAmHofMZbhRTBs55/5auk4+ofSPZKZ2Nn5/ku67LG2zTRdW3Keb2PkdX1HxF6P4C3VjTNt4YnOVMofBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEGiyEUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734DEC433C7;
	Sat,  6 Apr 2024 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712422066;
	bh=MKSYUuL5EWHfVs1stO0tc254Y3E6+JVTDm0nqhyRRPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEGiyEUUW70Z2/xp3+x1TmOHjA3r5hPqfcF2XI8c8S+gi96XEKBPSwMVTM046lnff
	 MQvUUvDaz4Fzi/uX94dUMi0T5TsyMPJAyuyMeMDe7H1B+v0210PgO/FnqUGhC8Gcu9
	 im6X+MQcV5jUQwBcMeGl8ZeYONfV22wgOScpUaJCgaxGeQJb8V2j4pnQon70bDMPPb
	 OnInBFki8EPdwbfQLjEvf2U0WKLQl/Gt4XcDuwJvxRt9yA/mRdGjzF8sDYOam7ofO8
	 QZyTZvpfEaiA4sHgTpx2errhIL47fGp0OD63mvZRTR75QpB6/8YguKuOqI7DE0HaZ4
	 0Az1XV5xIGxzQ==
Date: Sat, 6 Apr 2024 17:47:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] of: Add a helper to free property struct
Message-ID: <20240406174734.0a994e52@jic23-huawei>
In-Reply-To: <20240404-dt-cleanup-free-v1-1-c60e6cba8da9@kernel.org>
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
	<20240404-dt-cleanup-free-v1-1-c60e6cba8da9@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 09:15:10 -0500
Rob Herring <robh@kernel.org> wrote:

> Freeing a property struct is 3 kfree()'s which is duplicated in multiple
> spots. Add a helper, __of_prop_free(), and replace all the open coded
> cases in the DT code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


