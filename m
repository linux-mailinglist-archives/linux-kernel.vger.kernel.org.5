Return-Path: <linux-kernel+bounces-35081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B745F838B98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704A7284660
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F795A784;
	Tue, 23 Jan 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsb/ljTO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970459B57;
	Tue, 23 Jan 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005203; cv=none; b=XjCkZDbLSIidllmUOJog50p8ORCh50/Djpy9/Srh1B3r30yb0jSj+JnWU2ZlrXzC7kcDGILlpwGeIuqqGEakYN22uDx72kkIQD9C4G3J17FgeaTPKJal6+y0QlZtNa0vZLXwAOB04PNN4YoT2YXXxTW56y3/rmMUWmrfr8bzQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005203; c=relaxed/simple;
	bh=gcnsT8tXj9EkNlSqrg59YnLPO0VzF/drEtrfu+PruWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G2oyfN0CWHQCcd05JpLygRp6TVpIGn5yWr8mvDnmQrwtF467cFeljJU4GjBsLOVDAiVeR7TBjjm9VLG9UcWozxZ9ybCgfYPPMsPxLvBGPVAujSgBCd3qbX7YuQx28P8lAfX2kOkPets/HYy5COUATmdd6I4PAE0awZOcF2p0nII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsb/ljTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF8BC433C7;
	Tue, 23 Jan 2024 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706005203;
	bh=gcnsT8tXj9EkNlSqrg59YnLPO0VzF/drEtrfu+PruWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tsb/ljTOx+w9mpxG0I9fD/QNvkw4WWdgBggMqZP75CVx9sJ4dO+OusslEtKhV6Pfc
	 pV0TkxOwNdDdQ3hUTIoTvGavyaie/6gtGaWfoJwrGzKH0kqahBzlOS0YZKTb1gMjcj
	 nzlv2iin2Iq8JjIA/TKaPfppBuBvqEUwhAN35ltSBZ0JTYqjqsjz1FxQ2AOwdnFw9Y
	 vf7WfAkvY9q7UZq0Ig0ocfDq/DiYCO8TmnVB0QUT2QCvW2wZDVVDzQvTPeKCDNNBHF
	 wBW3qo186hIakDc1w06MMXLphs+t2VOJAJVWarG5g6CxWGuVygpSoVtFj8mvk0vpcw
	 8I8rkg1cojgrw==
Date: Tue, 23 Jan 2024 11:20:03 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc: djogorchock@gmail.com, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] HID: nintendo: Remove some unused functions
In-Reply-To: <20240119072729.54499-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2401231119530.29548@cbobk.fhfr.pm>
References: <20240119072729.54499-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Jan 2024, Jiapeng Chong wrote:

> These functions are defined in the hid-nintendo.c file, but not called
> elsewhere, so delete these unused functions.
> 
> drivers/hid/hid-nintendo.c:670:20: warning: unused function 'joycon_device_is_left_joycon'.
> drivers/hid/hid-nintendo.c:674:20: warning: unused function 'joycon_device_is_right_joycon'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7992
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


