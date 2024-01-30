Return-Path: <linux-kernel+bounces-45334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B5842EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B8E1F25FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DD78B55;
	Tue, 30 Jan 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7087ZLH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FE76C96
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650438; cv=none; b=cIRsDo+BKy3kjJxababIpeq+LpQcaNSAyf8FaisgFN7Q9xbfyqDQMqtXDvXdmZ+Ln+rPRlICiRx70mnHz/7jXS2vUabt6AmxkkLZ4nETTSRTe8hSLCHqbvqg8ABNuImkAdtCmK982VSF+Z2LkTjMWCIOyGLyEUanPNw1jOeyi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650438; c=relaxed/simple;
	bh=bNWTXXo6dsYOEd4Hka6WAzAtUkzwLrlQBpZ1dE53cfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0GhP+46Ns7ZhZpLWXRJeb0OdEoSf9qDBV3ZdSp56fnHBGJtLPiGEvTtfU+yicwymp6iLO3TYDaYvDEEOxVdGADRZRSTznCfaQVRmSXf9KORnUS+4pzL8Z4glKXKaKneyVZ5hAmFOns8e0Tp5yBCdrzFLQODiBm6HHA64a4LWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacobhxu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7087ZLH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacobhxu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so3463910276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706650436; x=1707255236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNWTXXo6dsYOEd4Hka6WAzAtUkzwLrlQBpZ1dE53cfQ=;
        b=O7087ZLH6aQG15h+eLZZdDiXTpYjfYV64ax4GoZ7D3DkcCjKaghOEYfCTEmfEjxJIz
         emUbdgzX6EXsa9ung10LQ2CBPcAjBJMufXsn8MeCBuc3HZr9qS45Q/jPKCPhERfm4L8b
         u9i3yoBblIckayRGbI62Dl84cRuZF3ESCPIQKFrFYhoQEFH5G+2joJkrd22Z9XVNHxY/
         E6fUe3XNCLKxwMUW53w2svok3qXQHM837OjgOc+orkURt/92DPsULEAv5GucCh/+oSgU
         pq9yQZtfVxysJ+gq/iE6MTyw0yc5aSi+MNoCvCt5Ixl3KfrlJxNapSEPS/2SbKQF1FoC
         mm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706650436; x=1707255236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNWTXXo6dsYOEd4Hka6WAzAtUkzwLrlQBpZ1dE53cfQ=;
        b=WVScZZRkWbXYgWuM0mGqCeqdelLbr8/k+gzxA4fhYbcEWqWoY4jE5dbILzg5tCQjJG
         FMEIMsgzXa+6WSTaC3sLR2nlJ3c0mO+rjChT+3xXIV/b9771Y5KZKE3yO0XAmmYyT8Q6
         tlKrizEHEApuNyJ04iZGjBjsDokBDjBeipw28BxhFX2giLOdnQ9KMh2MZlngu4vHojTb
         dQ4JbwQnPFSKQpKM/j4O3bSx+ScgLPz/Qt/lrs41lams+jz2M4KQgL/uMW/PsYJR71sd
         GsQ9mmb3klRqXG4TlgvTh4NSZEGEYkfOAyNWaeRAzcosX99nle9n3TtH10xlA6xEDkcn
         ub1w==
X-Gm-Message-State: AOJu0YwLx6u3YLobFYlzlwo9mr8T5kFq7Tb/k941gujxEJfNVuIowuo6
	RCu5BCBhFjRkCzpCQiUJ8fN/FU2IUqTwiXlTQpyp54+uKKqO+291xZX/xTjQz5E0ymf80lMQ0Me
	JjC518nYGPA==
X-Google-Smtp-Source: AGHT+IEzLC0G3ty193Oa2nlKOFME4eIm92RJ6h2xhU3YLLWhI0FWPsTy3+yZORdbDTuGDX0uUtBupd1A9HdGyg==
X-Received: from mhmmm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2ad9])
 (user=jacobhxu job=sendgmr) by 2002:a05:6902:160c:b0:dc6:5289:454 with SMTP
 id bw12-20020a056902160c00b00dc652890454mr3234445ybb.11.1706650436083; Tue,
 30 Jan 2024 13:33:56 -0800 (PST)
Date: Tue, 30 Jan 2024 21:33:54 +0000
In-Reply-To: <87jzribcvn.fsf@jcompost-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87jzribcvn.fsf@jcompost-mobl.amr.corp.intel.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130213354.863963-1-jacobhxu@google.com>
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
From: Jacob Xu <jacobhxu@google.com>
To: jeremy.compostella@intel.com
Cc: acdunlap@google.com, Thomas.Lendacky@amd.com, michael.roth@amd.com, 
	ashish.kalra@amd.com, bp@alien8.de, felix-coreboot@felixheld.de, 
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, 
	mingo@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding some AMD folk to the thread here.

For AMD CPUs, initialization of c->x86_phys_bits occurs in
get_cpu_address_sizes() which is called from early_identify_cpu().

However, early_identify_cpu() will first call early_init_amd() which adjusts
x86_phys_bits based on the PhysAddrReduction CPUID field.

c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;

Thus, this adjustment is ignored.

Adding a new cpu_dev callback to calculate num reserved_cpu_bits makes sense to
me, hopefully the AMD folk can chime in here though.

Jacob

