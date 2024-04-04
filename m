Return-Path: <linux-kernel+bounces-130763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0F897CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4BB24E31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590321C36;
	Thu,  4 Apr 2024 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeHuldDG"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC5803;
	Thu,  4 Apr 2024 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189194; cv=none; b=b1HwhNso2By1Bcp3aVr7zxclkU8QU33V1DvAq7KqNmraWpJpJWuzgQiZKA5vTvAQSHaKyhkhY4Y06QQfOqI45FXaMcxA07IsZGYgVN4JtmQkii1oNCseNXm/YEldDsVROTJgJt90i7hNbhyfzJ0a6irJzZjLh2kT5VgrZCVDCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189194; c=relaxed/simple;
	bh=F6iLoWS96SaQOlKJNBhFx7hfIo5Z/k0Vsx1FPq4aK6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FlL+TJVGdmU027bJVf+TQFhWAb5QoMtuKWEdQHy3afCairL/kcuikkSqQvSNQ3h8zmTT93hLIg45jjyZam2X+zHSECxhFxQSYcwttYvRSt9vkTXjwS08LIuAzoDf5UZxHiEX5N+FwV/RWbwpfYMJC4WiF00u1lkZNdB7DQ6rryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeHuldDG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e0f359240so503999a12.0;
        Wed, 03 Apr 2024 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712189191; x=1712793991; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F6iLoWS96SaQOlKJNBhFx7hfIo5Z/k0Vsx1FPq4aK6U=;
        b=KeHuldDGyw+rrgpdS3ExdvElMP7OrX14O/73KNn8KCqYIK878eHtCnLu46AxBLM/+Y
         Zb3R9yByfB/fO/Iq7AMDH+9YxlT3oknalwuCXBDVGeyTLeEnMdBHef1MTWer3gpduuXL
         8mxagZPLRbqcipZA1TkeVZqGOrblmqWY5t+pWJGcrpFPzJNyif+aFGqleyYfhm0rZSA4
         iqnse/nzVqBqFaBk377iloNIDmNs3qQJrGGqZCt3GPeOvmb37RTwT8Eh0z3pWsBPXqt4
         XdkMUJfrvDWeS3sRtcYEyvc0HJtIOlMJdrH5tSYx0ADU6Kg4qOsGP9cuSbC8Rkv4rBpK
         tlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712189191; x=1712793991;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6iLoWS96SaQOlKJNBhFx7hfIo5Z/k0Vsx1FPq4aK6U=;
        b=Dn8kdmkq6/JlqXeXjOfRwX3GQrHPNK0q2pbt68K91dAuQnY536sXwE3I/PO3ArmhY1
         nIcJKn2TmmFDTQfuEMNF27D2UgCkwytiQ53t2UwySBOvK9aTi5Gw35o6NPQJ5eDPnifR
         uM9z/NN5XsY2FCNvh4ny9G6zW21U35Yp6syFrgU9acbb8fjbi/pm1skk/ZdLK3Q/RVE1
         zfqh3joHZMSE7nrEe3xlTccVlrvP82OQy0bUrICudu09zoEvq0wugNdt8Orb1NSrbB+V
         1OcFkFLofdJvT8YvgchhGC10fzbfgFgJsp34j+IlksewmiAY7pKzPMWdnAlTHwX9E7ys
         zYvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7a+Cwm9oTtp3FHWwz1RCwP82qq3jOgvYYlPRMEX+HEoqCU7goA1McZ0WpUvejrWxlJoeuZU2AwqaKaUDe7cndK7c44f0sRjbUTBwe
X-Gm-Message-State: AOJu0Yzhu0P+oSf1B/lmfA4qGBCd6qYuRiwtagq9ABiZjTrZurN6P1Ah
	y7rc4W1DWsFensqDjlHze2jeptzc0k8yY4LCAUIh73Zpqle4/WJp0Pk+/PXh6Nej8/zeMyLKSVx
	HsGLBYxiNrBWyHO3k8uLYIsS/9hRNa8zU/jY=
X-Google-Smtp-Source: AGHT+IEC695Y8Gg+5GeLattzp27PbPPfvn6sqJXHFlyFE84nAnSO2kRCFby/sWqd8vui8Dt7CYPFwCxyjYFjQlrmNE8=
X-Received: by 2002:a50:9550:0:b0:56e:6aa:c7c4 with SMTP id
 v16-20020a509550000000b0056e06aac7c4mr431334eda.42.1712189190960; Wed, 03 Apr
 2024 17:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jon Maser <jonmaser8@gmail.com>
Date: Wed, 3 Apr 2024 17:06:19 -0700
Message-ID: <CAF=mWJMirRoAz1chFEEbg3qCgCxqbM0wt88wMwfDfOuXJTmr+g@mail.gmail.com>
Subject: hi everyone. here are some c tips for the kernel.
To: linux-c-programming@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

instead of running around doing stuff like adding pointer to pointer
functions to structs in the scheduler and pointing them at an
algorithm or adding global pointers and posting patches (but after i
read the source i will independently until i release code), i decided
to write some things id like in the kernel

but here are some tips c tips picked up

pointer functions to and to in data structures ie Struct **fs(bffs
handle) and messaging
data structures with lists as return types for functions for mp and messaging
data structures as return types and arguments of pointer functions
the linux global macro function (suggestion)
global structs, global pointers, global pointers to pointers (ie. you
can just access a kernel struct in a module without a macro or much of
one)
the linux c/python tutorial made in c
more gnu/programming languages

and it would be nice if someone wrote a fancy, universal debugger for
the kernel, something like, you can check loops and directly in
functions if compiled with a certain flag

