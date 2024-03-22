Return-Path: <linux-kernel+bounces-111797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B82887116
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76FB1C2147C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B5604AC;
	Fri, 22 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVkQMTs3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F64604A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125825; cv=none; b=Mbdg1yqgjoP7ITW2Wk6puT2JadfYnImTIrJlBhYrHCug6U0IjpsvgexGIUpauUq7EqcIYeyuX31DPV0u53oI0BZZuGU1JXel7u/9msjmjyP2jbjHCwPU5aSu8mOhTpf6y0IDV00mjNk9YyNSNL2WfMstOYdVAQEoeKEFlJ+p0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125825; c=relaxed/simple;
	bh=wsY+ApQDghOaF+qH6PoDRxl/mXk2ysfojy9BeWkg2KU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=IgcltP92OjkY7+LSxZjbpWrzNNfzxpclMYUuY89ul8MnZ9OIxuWi/LB0M4Gn42zzuQJgqQ5DHt2lm9c+CiYTJbTHug0IBjo9vzvn+Jn7H3QlFV3+36TZYEnIfpN//sdmrOph0y7i4nB/daKmyjwZPzsJPDuB+0mhjfchZ7+Aglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVkQMTs3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41412411672so18475945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711125822; x=1711730622; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsY+ApQDghOaF+qH6PoDRxl/mXk2ysfojy9BeWkg2KU=;
        b=QVkQMTs3bLQ+6FL4wGFWwSQB3uE82PCcy5QUGy5RCazec5J2f/S/qFDKj9G0CK951X
         QVWu64TUzN1dUXsdqjOqNLsmVwvoI91r4//Km7AdExF4pe84Np6k5yIRDaEdLwTo4AmP
         FRxB8Wu1pMIiZCKzX1FFG5ZKTrf6IvFlCSLgEEIt/GkXVl9FvyQOFF6UbSeGQlYTTCzw
         su4UWH+MT+ZhyJWWM+XF/IK0lMnpjLd/mxkjUV34p++GclV5F9lw9i+MHnZ5HiYOfPym
         whv5ZDvs4vceZUJHZVc5k0cKh+d1wbXYIh7Oss7egs56I3mvlOG/Jqay09x/eCOkUMB6
         iHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125822; x=1711730622;
        h=content-transfer-encoding:subject:to:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsY+ApQDghOaF+qH6PoDRxl/mXk2ysfojy9BeWkg2KU=;
        b=W1sqru9Ep3ZDWQmCcRIh/OJ/h6NgpAPql6AEkmWCtnvRMuKHKEffo5I92wwfSugtXN
         VsdALtgTI5WOaFZNBCWB9VKz7ivrLOfz11HuES3S3Zsqy1QctpyKW73ZVrpHeK0/8YW+
         f+S/9B88M9FQ4YNwPAyU1v00DyN5PR/YvHReZYi+XnKHPZtWfgg8Li8sODJjFALTOD7j
         Y0bFTYJKQ6Co0tSNIyDXMfoa/LnPNbsAuHj3/LXVkY1VlwT4Fw3q7he32agpZ5yGIaIr
         vvCNtopHGLcr/BnFgfrgmNisLaWa3msWzJkNOt/xB2Sha/dRMyE6WGFvX73da/me64rM
         pOqg==
X-Forwarded-Encrypted: i=1; AJvYcCXB2qMSqbxra2T8hdPdG8bD9EZlBnUeJ1Pk9V1fDJ8L7LifXRP1+6KXq0A0iNECphAICQFQwG6/bKHyTMIJXviz07vuJykm3+NfZcRe
X-Gm-Message-State: AOJu0YyNhba/LCSnzmtsxCzuwcbTPf54WMitsExZDa7SdJtJeqCzBTtv
	zznelIkp6akL1RKkNM2M7A6Rtnq/RxIOi5gRAduZykeqI0FeqgE=
X-Google-Smtp-Source: AGHT+IHSns2Vx6LicO8ebh39yDGn8/BztrvFn5zUcULS7EGXnhhSxi4KNjaTfICapBg8pv8cZ7FY7Q==
X-Received: by 2002:a7b:c042:0:b0:414:c48:a90 with SMTP id u2-20020a7bc042000000b004140c480a90mr1820705wmc.24.1711125821730;
        Fri, 22 Mar 2024 09:43:41 -0700 (PDT)
Received: from localhost (191.red-88-28-8.dynamicip.rima-tde.net. [88.28.8.191])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b0041469869d11sm9398234wmn.47.2024.03.22.09.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 09:43:41 -0700 (PDT)
Message-ID: <c0aa8322-f034-4488-8e17-49b211e372a5@gmail.com>
Date: Fri, 22 Mar 2024 17:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, maintainers X86 <x86@kernel.org>,
 KERNEL ML <linux-kernel@vger.kernel.org>
Subject: [ arch/x86/kernel/unwind_orc.c ] WARNING: stack going in the wrong
 direction?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In Fedora kernel 6.8.1-300.fc40.x86_64, dmesg shows:

[18179.599501] WARNING: stack going in the wrong direction? at do_syscall_64+0x86/0x170


Thanks.

