Return-Path: <linux-kernel+bounces-94131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE76873A5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F859288A63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B8139581;
	Wed,  6 Mar 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uibrp1QN"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A9134CEC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737747; cv=none; b=MWYzCxcr+E2WQG+Hn3zaf/oQsnuJWirwWtVbg1DliM4Dw+6N6miWOBM4xi8fjetbYp/vLzYhHi5vExtO7JzpURXcNkKH8rCGyJlyG9404tM8C2Z89s8K5uxpokId8T6mYaUou/v3AsQneNS4qA8If3buZNfx5yg4ngzZFE7wqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737747; c=relaxed/simple;
	bh=jbtDCBpf12tNWjIi8xNoPvKMmgV3/4H7xox9r9lT4k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grub30AUHOK3db+eoWr8ewqcg4ZhZhWOaQWcpHcviF6tOZ72b+Rz2zcX20l6oyNBLfFa/FjXwF/cdABX1pjKhE/bBIqLk1m4jQhitvOys10Cind/KdPeYsG8nyk9v+u08i6xSnG9F8oJ8Ck7rFWEqDmru3pR0dzcunqLXIuKsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uibrp1QN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so5478613e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709737744; x=1710342544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp6x815KAY3JWPUiKmoiGn3qRQ+0HmVIas1eOpRKDhY=;
        b=uibrp1QN+S1ArrZGDHb4jFhBowuuGUTV8UfBtQ/hTViNbWuCMim54J8drhL4cE+vc4
         hp9Q5Vsi3TbNaadrMy/s5eFtMLhKck/a3L37yVU+Lcv1o4bGS3x/5UD/o78jbOIrGMW2
         TeQLxDKHnLA11/kRARINn9D6BvwiJAFl9aCPLk3OHtxF6UYYHcLe2/JMQJ/d+FcWT1OU
         vo0LIpkDX7x3eTLM1U23V5/Bz/9aH44VwtzcjSvaDZm1/IL4lpa9w4hUMcmkYxrHNDfz
         BKZ/V9LU1/xJKzIhROpmsluTGXEWNr3Un/9q+QhnJCY3MS2fCLxj6HcOXTYNctC+dKql
         H2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737744; x=1710342544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp6x815KAY3JWPUiKmoiGn3qRQ+0HmVIas1eOpRKDhY=;
        b=EkUdc2yJoeiSwKGYhKE1thqnw7QrD74DcpwlSu8CSGiE3ly4LzK59Ac2ZBMCP/D6ep
         88677XbY/bat5U7aw9I5jStaO1BYL077+Hgb3794GKWGmeWGuD4fN+ZVYo2E2k064kQA
         ArgwM5xWviVirhrdk8Cssc7wA9XlUMiKir7+gx0v+77fZ/I/9A4nfhOVOgXnv2yTS2qm
         /UuxGsXV7XD34Emt8JWqEl93MtCOFEw6QZj52f1z8aZYzwxlY4vFMpB14cDq2VGYyCKI
         eMM+G8A1DSGKjCUe87BaTSeNfl7HPLutXf/b2s26auo+TOGzvRC8L1TIzzkrrAXxre39
         tnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgNy6VxrGOFqDA3iKYWHIrBP52+S7u4GSvuOuRd95Ah6Acoau/S32QqKRTkERpiTnfUFPk5TfVXf/8YfhSfBdJfYH7xw/AbWYmHfPS
X-Gm-Message-State: AOJu0YwUqNeGG5EnieU09gRzDWvjefmud7ZZxCY1/0dzn1VajLzI0gD6
	sCEWmme8LBHwOR+p1TJS6AlqNYxkCG/KG4/p7J1Rxr3HjfKWzRdH8AVYRiwlKYI=
X-Google-Smtp-Source: AGHT+IHpVdrkldSOry+sg8KBGgSikEKDS9C7yH+jRteTOiUQtWcqqLQ/HiwwjaWDM3cPQlyoxPtIZQ==
X-Received: by 2002:a05:6512:e98:b0:513:59fb:1a50 with SMTP id bi24-20020a0565120e9800b0051359fb1a50mr2969946lfb.54.1709737743509;
        Wed, 06 Mar 2024 07:09:03 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041304100fa9sm288447wmo.45.2024.03.06.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:09:03 -0800 (PST)
Date: Wed, 6 Mar 2024 18:08:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>,
	kernel-janitors <kernel-janitors@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: checkpatch.pl getting stuck on a macro in mm/kmsan/kmsan_test.c
Message-ID: <2bac2cd3-ccdc-413f-aae7-110b5c36122a@moroto.mountain>
References: <CAKXUXMwCdV466mRd4K0ePV73qDO9GRAph4KuC5nQ0JAp-ouemQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMwCdV466mRd4K0ePV73qDO9GRAph4KuC5nQ0JAp-ouemQ@mail.gmail.com>

On Wed, Mar 06, 2024 at 10:33:55AM +0100, Lukas Bulwahn wrote:
> Dear Joe,
> 
> while running checkpatch.pl -f on all files in the kernel repository
> (v6.8-rc1) for some experiment, I noticed that checkpatch.pl got stuck
> on mm/kmsan/kmsan_test.c, i.e., ./scripts/checkpatch.pl -f
> mm/kmsan/kmsan_test.c never terminates.
> 
> I could already boil it down to checkpatch getting stuck on the macro
> #define DEFINE_TEST_MEMSETXX(size), see lines 541 to 554 in
> mm/kmsan/kmsan_test.c on v6.8-rc1.
> 
> I do not know if it is worth fixing, but certainly I was surprised
> that reasonable code can put checkpatch into some stuck state.

I think the bug is ancient...  Here is a stupid solution.  But afterward
it still prints a ton of Perl warnings:

substr outside of string at ./scripts/checkpatch.pl line 5158.
Use of uninitialized value $op_type in string ne at ./scripts/checkpatch.pl line 5164.
substr outside of string at ./scripts/checkpatch.pl line 5158.
Use of uninitialized value $op_type in string ne at ./scripts/checkpatch.pl line 5164.

regards,
dan carpenter

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..bd7a286bc1ce 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2260,10 +2260,14 @@ sub annotate_values {
 		} elsif ($cur =~ /(^.)/o) {
 			print "C($1)\n" if ($dbg_values > 1);
 		}
+		my $old = $cur;
 		if (defined $1) {
 			$cur = substr($cur, length($1));
 			$res .= $type x length($1);
 		}
+		if ($old eq $cur) {
+			last;
+		}
 	}
 
 	return ($res, $var);



