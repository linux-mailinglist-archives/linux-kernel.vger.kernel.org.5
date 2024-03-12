Return-Path: <linux-kernel+bounces-100146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E387928C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8FBB213D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF179B6D;
	Tue, 12 Mar 2024 10:55:16 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8377F00
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240916; cv=none; b=EYOlXKJiBPmkDTcFknpUOsvQ3zMTrlEJ0gTOk0OKoVMz/X9xRAHkmzPBe6T5a0adQwX3UmsPkwECy+27g4JKzWTkEh+opEkt70XWslVWhv/B0qDCulTBABUkRlI9eiz+0ELtCET842o5twIZHHoyIkKmwSg6ArytybA/M5rhq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240916; c=relaxed/simple;
	bh=j7aDBG8JUvUi8lwL1bWk+WpOhLiCDcBDJp39nC4wfr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmjF3zaLPBmrXfyZRYtr1RwdOxl2MUmHYFAmOeSNPBSrJTQu82jg/ISB8VnT9QPRWdi02Yl0K2xoLT8kd1ZzXgokjKNtQLscZLhL+hppwopvlRTzQaj/KCNnde4F6kfhjlwlQBz6b43STwgSUxvepQFg/QmvoZWiZVtLi90G4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.55])
	by sina.com (10.75.12.45) with ESMTP
	id 65F0347F00009958; Tue, 12 Mar 2024 18:54:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8936331457689
X-SMAIL-UIID: D607E81DBBDE4A0C977C9F78490E4453-20240312-185459-1
From: Hillf Danton <hdanton@sina.com>
To: =?UTF-8?q?Wei=C3=9F=2C=20Simone?= <Simone.Weiss@elektrobit.com>
Cc: miklos@szeredi.hu,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in ovl_llseek 27c1936af506
Date: Tue, 12 Mar 2024 18:54:45 +0800
Message-Id: <20240312105445.2051-1-hdanton@sina.com>
In-Reply-To: <03d7a29c7e1a8c5741680ea9bc83b4fb40358a25.camel@elektrobit.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Mar 2024 07:10:27 +0000 Weiß, Simone <Simone.Weiss@elektrobit.com>
>
> For some experimentation, I have been running fuzzing campaigns and I
> noticed a possible deadlock in ovl_llseek .

Feel free to take a look at another case of deadlock [1]

[1] https://lore.kernel.org/lkml/ZPOtwcMHN_fpdrpt@boqun-archlinux/

