Return-Path: <linux-kernel+bounces-134210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646B89AEFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C601C209DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E1DDBD;
	Sun,  7 Apr 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5wlcYcp"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C17460;
	Sun,  7 Apr 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473304; cv=none; b=I99/S9buJxfJVR0e9L9HdRAxAR/G59V3QL70SYNUYyS2R9hMU9eOf7X1ZW43n3Rw1nNxwuWhxCKqaD2Wk411faNEH2B9FR9/aHK0hefU8a/eq4sxLO34E1WYJWUg5tZSKFqtQdHhz/RgC8hMrBVweVxAOR/HrbUY3/nGVdKySTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473304; c=relaxed/simple;
	bh=GriqJA+BYyLgYfZpsMFicLFrLZ9pmxr/z1qTDm3j3V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOGOoh7kB4bHqWqCj0KKmGqLL6nkXVY56Jlb3PJrLh2Eqc+WSr2FX7GkMgKm3aLBbVDiivHtBbOF2cFlatHU8W42YuRktet6Id//8mag5OO5mQvdrdxL9vrmZXElqSIhE9GSe5KdAmfDg0xEaFOnLQRfBPW9v20LDbEw2xjoRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5wlcYcp; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso3442238a12.3;
        Sun, 07 Apr 2024 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473301; x=1713078101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GriqJA+BYyLgYfZpsMFicLFrLZ9pmxr/z1qTDm3j3V8=;
        b=V5wlcYcpgPqieulsi4FgKX+NCa2J37TdHP8pO07oZguaYAmS7nq3Ari8+kthz9FlIc
         /nccdr7X8Xvx5p1og6K2d+BZrgWtBreMvSRGVoSC2icW60RmjI8pZb70qAjkzaj8nST3
         2sVY0xX9CFOViem8boxQJ4U+UIS/u+XcwYUk1a3TrZJjVKyQURpoEmxY5B/r4Fdb0zel
         MPjn0/wkOT9nTVjG1xp2Ukps2P6GfS3G2LLCiCvVWNVVUscUZTH4OQfUivyAoV3lw4Kn
         KRMKqmrx3ncx5+a2eGh1eJcZeKAOWBOzGdJTy2gafEQqfszIAGlmkfo/GEHpi/DPXvfF
         QRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473301; x=1713078101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GriqJA+BYyLgYfZpsMFicLFrLZ9pmxr/z1qTDm3j3V8=;
        b=PZv2gHzY7CpJPCBh4N4I9h5EGf0pVfoq2ixfXIdsA7JsJi1UK/LURe9BLy3XtPVDsg
         NV27mcpJ1KLKe45SMPSwokfFBwywWixjV48xh3tTQK/MPg5Dkhi7Gr91QxVMr0GwMVVi
         eAPAVjbBFHn6RKe9JykOxs+tD1QkbeFoc5WD9xQ+kbVzyNxKzYluTDYE/71py7DSHWDm
         8rVq0MZ4K4lzEG/kOX23jwCqGC5mCjBfsZOwqP9eSly/yroh+uLoOlHc+LZAk9I2zhQc
         bsn3kLMSrVxoa/x7KZSMlUrvd3bazNasA6wiDStb8bVKGWJXXmvaTMEYkRtyxrx8RI5U
         3yTg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOYZZ7VbqWcGGb3pORS/HUxaYmN/2VEQakTQcU/HMtnVRtw4o2xSXilUcSA8QA6bVNSt60QH7VbIPcDsK/5INpuBt8T6Pv7vvq2DPoYxXAXJ2zZZLOOe4Fac7q26VPKE76eUR8d1QNQ==
X-Gm-Message-State: AOJu0Yw+VyNHn6Yox6hGGyS/Dolvu1i1HeiHa6aYNL1GFK2NKW8myZYr
	5mzZ4t/R0eEgWu8Q25EZleDVO9TUlEzcbxrzgmvAKO3vx5f4SnJ051sT5r4g5mhvyHbXMQ7pa1X
	0VhuIYeFwycn2+Vs02aT9zd6RHX4=
X-Google-Smtp-Source: AGHT+IGWFeLS8dtihNb6UVdEL0JvtZsJ8MD6xw4+Z0BMwwugWjK3Avqyb3yVlfLbkKkw46Q6/PWAWg3M1ih8nnaEECk=
X-Received: by 2002:a17:907:7ea2:b0:a47:16d1:113f with SMTP id
 qb34-20020a1709077ea200b00a4716d1113fmr5173127ejc.47.1712473300976; Sun, 07
 Apr 2024 00:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403014006.969441-1-qq810974084@gmail.com> <13a50e06-2b35-4cc6-a3ea-d6e070195db7@acm.org>
In-Reply-To: <13a50e06-2b35-4cc6-a3ea-d6e070195db7@acm.org>
From: =?UTF-8?B?5YiY5oCA6L+c?= <qq810974084@gmail.com>
Date: Sun, 7 Apr 2024 15:01:00 +0800
Message-ID: <CAH9++vFbOT1M3+HyMNRpdvcad0z4C9gn8YUJhX08wy7isJv2MA@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: Fix a possible null pointer dereference
To: Bart Van Assche <bvanassche@acm.org>
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi.

The patch passed the checkpatch validation without reporting the
related information. I have sent the patch V2 email, thank you for
your suggestions.

Thanks,

Liu.

