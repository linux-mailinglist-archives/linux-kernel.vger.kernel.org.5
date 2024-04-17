Return-Path: <linux-kernel+bounces-147942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D58A7BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E63A1C21A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8D5026D;
	Wed, 17 Apr 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLYKTe3T"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A43BBF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330276; cv=none; b=RI1Oc+0lcD6BIUgJGg0t4QMGlj0ZliW8hlzrIpkjX+Mh222lG7ATu6D77jOadjDhdusyXBfUO3nqIto7dDWu0cAO0DMrkAGnPD4ke6qADRXUgy0QAD6KLsebY1IE86L87QC4UY70KvxLE918i055RKI+rfloVaXwPOBqJdzu11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330276; c=relaxed/simple;
	bh=hXqatsTQLikf22gB6SIFnLqMwWsJGTXm5crtOsPvGJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Otd+XVLTv2FMexJGxDA5vPQMK9nL4HWFKPBvIpmymRH/E4hCWO64Csi/v/Oc7JlO5Y6xei9kG2DeJVev/X04speV/2w+TkAN2U2C38naQ/3evOQ98VLlwPYW+AM8rGKWU5NMyJy5wHadMF6/dZVz+SY41LHOo8OSlXH0VZyvEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLYKTe3T; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ece8991654so4648095b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713330274; x=1713935074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8cE2GY5Lwaxvgym50OvlfdzVbTihI4gujlM0wTOT/s=;
        b=GLYKTe3T2xk7LhK7capBGLb7whQghKgquHsTX5ePGUQBhogfOgGnRaEePPRlcKcH/O
         6OnOYGSGz9rnvIoFFj5lzrSohRajgxFF4q4Zf1SG7XJ332CdXbQdreRUNJ7Gd3hIQHGD
         mrjMFCJUSMvGcPM7GSM/O2Y8+JDTRSwlMRezvlw0/BZ/I+bHp4oVJajXkg+bQM5zMyAy
         dgom/wrTO1ukNwqT8PTTMGi5Ilx4ZmoAEva1vM8epiZvU5rLvyG90IIKS7iK2NWn8pkB
         zTHLTwE+ig3Yw09FFHIIE6DfCo3euWH6U0Z9GduUGVmIas6D8/ZQAwkrdGHvGq4B+k65
         5VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713330274; x=1713935074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8cE2GY5Lwaxvgym50OvlfdzVbTihI4gujlM0wTOT/s=;
        b=Vm90lAbuTjvxFaRCprtXG1JfEodc5PLjLjVyQK/BqJg9p+MIyieYiYC2ahbPQyJ8Tu
         Iezzn97K6qQSAPAftxqUyjT+JEeoI5Swls5B6JCVAPS2HEwK2lAg2xB9XcjMG7mQegRb
         Yff+LguVTryn8Err90jKFqMko4auz9V6inLKq/ll2UPJiCwTzbEv3yuGfypwj/ewwhlN
         Vrgwxxl64HonuwJQgVW/UUsLhIZ1najQxjlnbejcTHk+3w4x3YrdzoSsXGvw6ic0XYub
         cCtMsR98HYDvAu3oFx9LCMJXPvDfoDTi0GvHmiiP5d5iJFkAWYN8DrjmzuPI6F0fd4Oy
         /tJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDI9CP+dA9JqL5C8t+nkc3vdDaOZJBRNSd7zWMHGP/4iTt0/sqJ637DeHmiQZHLM2OfXIShUe7Rj9wOV4/nu0U+9zU7nfvjwbVClUu
X-Gm-Message-State: AOJu0YyGiGmNaT7GNkBi4o3+r5JCzOrL48djESJxogTRy1+Fol/Wvs2+
	KRqSIzSKuH1O9YvsOo2MBQdDR5e0HcxTeUfcx0y/B7gyo8ceoPKm
X-Google-Smtp-Source: AGHT+IEblF7vy2XSGTFmF24m/8tK5t0Ox3i9yE6fmQYAZ7wmKEsaYpKSL1iBeaHI10GdgAecyBosVQ==
X-Received: by 2002:a05:6a20:c101:b0:1a7:3d2a:7383 with SMTP id bh1-20020a056a20c10100b001a73d2a7383mr15516623pzb.18.1713330274448;
        Tue, 16 Apr 2024 22:04:34 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id hg19-20020a17090b301300b0029c472ec962sm484417pjb.47.2024.04.16.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 22:04:34 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: ioworker0@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	fengwei.yin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	xiehuan09@gmail.com,
	zokeefe@google.com
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes() batch helper
Date: Wed, 17 Apr 2024 13:04:26 +0800
Message-Id: <20240417050426.66194-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
References: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey David, Ryan,

How about this change?

static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
					  unsigned long addr, pte_t *ptep,
					  unsigned int nr, cydp_t flags)
{
	if (flags == CYDP_CLEAR_YOUNG) {
		for (;;) {
			ptep_test_and_clear_young(vma, addr, ptep);
			if (--nr == 0)
				break;
			ptep++;
			addr += PAGE_SIZE;
		}
		return;
	}

	pte_t pte;

	for (;;) {
		pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);

		if (flags & CYDP_CLEAR_YOUNG)
			pte = pte_mkold(pte);
		if (flags & CYDP_CLEAR_DIRTY)
			pte = pte_mkclean(pte);

		if (--nr == 0)
			break;
		ptep++;
		addr += PAGE_SIZE;
	}
}

Thanks,
Lance

