Return-Path: <linux-kernel+bounces-73677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A485C5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824E228272B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00C14C595;
	Tue, 20 Feb 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1uNTN2q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250C14A4F5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460762; cv=none; b=e8oZaOohPSZsfqmvDYx0zJXBdV3b2N2BA63MYfb8Tl/aXOmbig3zWhnJuraIjZrZOxdAiudN83tLS81cUucrTc+Law8zjGB7gl/D6/oIQ6bTlg9xpKg8p+Teom/yHgqjM9r16uqgQPjbwCzdKKSRsuLsgH7YGynryav4f+AWOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460762; c=relaxed/simple;
	bh=TX3j3zcBfIO+UDTjMXeeNuKrlq2w1TsjBZ98o51aW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGk/uHZiKHuF/Ve1OhQ2P/u4vJ2tpULyxbzBtsYhXaaxXNNXY3fRFdGKiZDQ7mzO3RWIfQ6pbdM4tHtvUR2uDKWkD+wG8mR/RBCkQ5mCZ2FTOFhXm33+CoQWiWU3KipyyZfcl2GcuoOiL4ph4g1zFtuhZJx6TkWsPgXLU9vYFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1uNTN2q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso5029782b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460760; x=1709065560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWNooNLHUoiH4U/9o1XwahWplCQNb+4img8KQcEfXII=;
        b=O1uNTN2q6GsIv3V+kkTQFr4nBF9GUlUO5yLgP1yYsC1bFMzPJNRi8jlU2CxJUskoq/
         SGWNKWZmScnsBKCoD70kSA7SC3HjJMPKj1RU2EVoxcIUm1gGm9TpIWEntQDg+uxqi5K1
         o3TDJUBtuU2XUArORDGc7jJnL4vIsGCYsT3RI2IG5jOZBqg1HFNb37667Tmqfm1GQSo2
         VQwra3RhtuDv9PwkO0PQiYuumLTT6kIjNBNo652T+tx6AV9yBzdupzYcvgP6xXZ3jOuv
         6jIMw/lj5/96gFRDTPS9DilmmYfDW+qGT4WCWEKGV8W6BBqOBsaNaTz4MbRIIDvdGqub
         gxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460760; x=1709065560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWNooNLHUoiH4U/9o1XwahWplCQNb+4img8KQcEfXII=;
        b=ehMnxRO2uGCJg6Pi7cCUw5At4PcB0Z8t3iuhp56Tw/uzuLUkpw2Tj+Ci0deEGs+gsY
         XJ3oTdSrfoxEnH61muSYibb9DVSg75MsyqfCt2CPZc56TGkzU+wkXjWyj1P0KC8wvTRX
         N4tuyLEEisWfs1OZl7Hc05YhHa3D/3CLpiD0gAMTfUypgni4p+GYO1FUQeeIh7CF7VBX
         ShJ/74/A85dnX70CFf8Bkg4bYzA5tO2F5jdac3Hv9STKEA0CY22TkNi/pt7izrsF/nz4
         qGdptzjkbUsUmadK5bfe3CJMwmkWL+YIyJm+gQNACI93rY6JWiPfhp4W+7wu8U4cHu2N
         gOag==
X-Forwarded-Encrypted: i=1; AJvYcCXJVL63HLhys940WcUqcQxiOJ08EYt8Sbj+fzETiO2IrPtESpZEcPu2nKPakYTVUNOtCDdtY1SJ2VPmA4T4mCTryaeibBPzsoRwBLz8
X-Gm-Message-State: AOJu0YxW1I/gIbItn0bsAwBSL5brn+x3FmgehYjGKRFNYSy0QFU/gMS4
	FVf1X6tWadfVsyBdU9Yj09uhPbsrzRJk+ajYNQIo3eSkVxcmQs7W6dHJlTY+79I=
X-Google-Smtp-Source: AGHT+IEwvFnN5EzqdSXE7grMVbIt6CCHBf0CFetE7A44b8k9FUKR6HkWgXYEoJf3QfFQ0naX366Vug==
X-Received: by 2002:a05:6a21:2d87:b0:1a0:8897:85f1 with SMTP id ty7-20020a056a212d8700b001a0889785f1mr17208812pzb.6.1708460760396;
        Tue, 20 Feb 2024 12:26:00 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b006e4891d0e2bsm393943pfb.7.2024.02.20.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:26:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 10:25:58 -1000
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement
 disable/enable_work()
Message-ID: <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>

On Fri, Feb 16, 2024 at 08:04:41AM -1000, Tejun Heo wrote:
>  0001-workqueue-Cosmetic-changes.patch
>  0002-workqueue-Use-rcu_read_lock_any_held-instead-of-rcu_.patch
>  0003-workqueue-Rename-__cancel_work_timer-to-__cancel_tim.patch
>  0004-workqueue-Reorganize-flush-and-cancel-_sync-function.patch
>  0005-workqueue-Use-variable-name-irq_flags-for-saving-loc.patch
>  0006-workqueue-Introduce-work_cancel_flags.patch
>  0007-workqueue-Clean-up-enum-work_bits-and-related-consta.patch
>  0008-workqueue-Factor-out-work_grab_pending-from-__cancel.patch
>  0009-workqueue-Remove-clear_work_data.patch
>  0010-workqueue-Make-flags-handling-consistent-across-set_.patch
>  0011-workqueue-Preserve-OFFQ-bits-in-cancel-_sync-paths.patch
>  0012-workqueue-Implement-disable-enable-for-delayed-work-.patch
>  0013-workqueue-Remove-WORK_OFFQ_CANCELING.patch
>  0014-workqueue-Remember-whether-a-work-item-was-on-a-BH-w.patch
>  0015-workqueue-Update-how-start_flush_work-is-called.patch
>  0016-workqueue-Allow-cancel_work_sync-and-disable_work-fr.patch
>  0017-r8152-Convert-from-tasklet-to-BH-workqueue.patch
> 
> 0001-0010 are cleanup and prep patches with the only functional change being
> the use of rcu_read_lock_any_held() instead of rcu_read_lock() in 0002. I'll
> apply them to wq/for-6.9 unless there are objections. I thought about making
> these a separate patch series but the cleanups make more sense as a part of
> this series.

Lai, would you mind reviewing patches 0001-00010? If you're okay, I'll apply
them to wq/for-6.9 and then post the v2 patchset with the rest of the
patches updated to reflect your reviews.

Thanks.

-- 
tejun

