Return-Path: <linux-kernel+bounces-63746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9A8533EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117C51F2CE20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F55EE99;
	Tue, 13 Feb 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTcI9H8v"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC15EE7E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836284; cv=none; b=HSJdwOvanl735xAkcUTWXv6dCpDGZa8zyYjJk9KK2WINttHBBfobSFY9g2Lk4EyJkeHKR56XNq5v1yUa7hxUSMrvBaLdTpFSX2lHcprYtSx1Cu/6le6LDdY8c97uEJifGqSnLPD72cpkrdmvHKKdeEr2zYJVUJ3ovuJeoOXHT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836284; c=relaxed/simple;
	bh=SI1JYaUoHkOLmojjYZ95VrhJvrphCqBsyJ0cAy/Is3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BhHyVrhxdGei+5x4ecd7OwaA5hGQ8u1ARFxzAX+sRvk007G7lhAmrTzzrgR1UPOAjnlj5UPskgs14eOp0e6UWFGMLue+IOhkaugJSqWBa/slkM7LKYcWh4D8x8rpno2kTFqe5re4K5SVNq7yeLzXwLn+2BZdicBpCZDLAOtpOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTcI9H8v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047a047f58so80459797b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707836281; x=1708441081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzO1t7Di7Fc9yeiU0bRlmcKokfI8GJJTKI/qQrGOk=;
        b=rTcI9H8vybwqA5czMbxCEXIrcVxlyhZXu6gLSdSwojLJzIhmLGE//3jM+xDi4w6tRD
         wxS5B2EGDmQdWQoUHuXdTcc2E8WTgeJmGrDwpdb0eirs1XjJ1kC/yX6igGxY7RwvFpN2
         iypG13uXZl+l0yQI7iGiHBXCDuSSSJu8JRYRu7kFoAvxHjZJt6zx4mx6W+zf3LJW1pba
         s22H8g1VcSAxAeL4gcJPAMIguqmmMvufJFab6hhKWWvs6zV3vLJeHvA7HBuTgNGMTlAY
         aXjcOe1FqW7cuMVh1s1GH5SmS5bopNwFdkIo0s/rb+CPOZKSvKJMBfPCfcpp7QFKTcQv
         SeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836281; x=1708441081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzO1t7Di7Fc9yeiU0bRlmcKokfI8GJJTKI/qQrGOk=;
        b=eTEbabmZiyzLNXxkmX633KbnI1h95pMjj11XK/zZn6Oh8YvwQ6e4SK810DKr3snCse
         XDnA1EVU535S4q2aHFfsa68v94/PLEGuH+XwnLMPsZonb7CD3aNOXh43L5YkJfmbvagJ
         V9W3aydCMjqsODWiq8o4wJlMY24IZyT6IXfn4SxGp5Ol0G4EPzmNpK2Raq6xcKMwsEsL
         8TSKFQV5aFFll/9KhgQ4oB3N9OQyhztAIZ12GMaczPs8AwVbOb2b8NfAbF+lOmFaJONe
         taVjLPBecGgXgOmxOejBE2J4+j/XwucMalQXZj2slSGMptaBDil9zI33RU6k3eSdMOpV
         HD7g==
X-Forwarded-Encrypted: i=1; AJvYcCWgP0z7aOZT6PbfmHHewfKLOD2KdLW4wpk3ARIp2c7fPQ50E3MSEGfdQ2xygLzPBovxO07MZxSGkCP3vLNK2ncBpV+XgpYddiRvy6Dc
X-Gm-Message-State: AOJu0YyFuDRSfRvOG1HSgG6zOSDK0VNAy4zQQLy1tWM0dGpkLzSNjiq8
	DTpOKUa3ce5fjCf7xGoLY5vheBEk9jNNzy2nVeAGqvZdsCdjuAEfeVDTVxa9ha3RyTYXDQJtr5Y
	ngZdxw8QpZgvd54M9vA==
X-Google-Smtp-Source: AGHT+IESdS8iWPEKgDoh6+53rMi+VNaoK022Qj/k/mqXr7o3EiEDCIxvbGXXPRaKlmahvRCe3k+zmaFHs50bMdLf
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1505:b0:dc7:48ce:d17f with
 SMTP id q5-20020a056902150500b00dc748ced17fmr2564940ybu.10.1707836281481;
 Tue, 13 Feb 2024 06:58:01 -0800 (PST)
Date: Tue, 13 Feb 2024 14:57:53 +0000
In-Reply-To: <ZctGwaTnEfkum50a@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZctGwaTnEfkum50a@andrea>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213145753.2423739-1-ericchancf@google.com>
Subject: Re: [PATCH v2] riscv/fence: Consolidate fence definitions and define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: parri.andrea@gmail.com
Cc: aou@eecs.berkeley.edu, conor.dooley@microchip.com, ericchancf@google.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

  Thank you for reviewing my patch! I appreciate the feedback.
  Referring to your suggestions, the final result is as follows:
    1/4 - riscv/barrier: Define __{mb,rmb,wmb}
    2/4 - riscv/barrier: Define RISCV_FULL_BARRIER
    3/4 - riscv/barrier: Consolidate fence definitions
    4/4 - riscv/barrier: Resolve checkpath.pl error

  I've updated patch v3[https://marc.info/?l=linux-kernel&m=170783431129245]
  Please let me know if you have any further questions or suggestions.

Sincerely,
  Eric Chan

