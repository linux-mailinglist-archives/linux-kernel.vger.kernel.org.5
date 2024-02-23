Return-Path: <linux-kernel+bounces-78952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB586861B47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573211F27BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752C1419BA;
	Fri, 23 Feb 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne/47t1y"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662A13F00B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712101; cv=none; b=X1/jJALg0JHeQllzwQOuvyqGvRUrPjkTcvYsZ4mxQqsS4q2HxB5AImXROYXRB+1fVzwjZGc9ccIu7/9K57+an7tq4elMEw9sAfKAWZvWfCeTjK5w2ahMAzXcbUn7W79CFEbfr9nYX721SeDNIhUNbKf3Q41dEegzJvJFlaZnCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712101; c=relaxed/simple;
	bh=Bej+JJ3v6fc7i4XxpJGQQXY0IntuLNtJu33fXgwRuYM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YyXUQjIRuHAu+vaPrTJRAtaBoyUj0VMea+CTt8EUgbhONi1hX/1IB/vm4PVVNyBiJqWkprjYFZ+ga8VtU0UF3m1jIqCj1nE1KeEiIZUkArgftNeMWWzzE2yd6ToL9eB51IHqcIgd9vMDq5FcRHFM0UdDtjSQ9cojWDjYY4UZ9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne/47t1y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607e60d01b2so7915187b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708712099; x=1709316899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bej+JJ3v6fc7i4XxpJGQQXY0IntuLNtJu33fXgwRuYM=;
        b=ne/47t1yZ0oWUL9BWHqEHqKMyIoD217Y3/6OU35bLwodsbU0t1p3dyAKvoFtb3KF+9
         CCULI6Dm1De9OXGF/kMBzBNaZcAAIOHdbDZvP1VNwuB6cwypwSj7dkeDcsIiZQAV1fF6
         VPFXaE6Sb+zXiG8VCvZr3tUn+4bnO+MOKa13vQqkqQvhxjKI3gQEMiYdJqdTDywouzEO
         A2UZl2PNxYV0vPjk6uYghjhYC4Y+EvK9R3ZEyU6/lZL/JLbTXvG1Jf0ziRbFjKK0gLRQ
         lr8Anm0NQqMEQU4zh/NTYrIgrfIHhoHpmQX3UaznpdmVvXR+J+T0kU77DMq2p8WBrNFq
         /xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712099; x=1709316899;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bej+JJ3v6fc7i4XxpJGQQXY0IntuLNtJu33fXgwRuYM=;
        b=da9lEs3HyVwLB62OSN7Kdxjd4mC/0/HJtVK67VuSKzAzW/YTAfS4ncinPUumO2ZeT8
         xAUE42g+n7jmYjrSpDpBilGq8nbW3eWyz6eG3Ahi+KqTGbs04Y1yEcPjQjEjZOjNDCws
         8iwwALNxMy2scMbAw54zSP12elRYDuaT8ty0gZTLqDaLTh8LNP3JDyWEYPm+4fq9bdH3
         soYXU+moDMEz94x8SKaovxqtYD3w+HAIESaWO81v1yAW80KdpaZ6ICR3FjK3DSDq1h6D
         RbALfoeJyQOWWrepk6K1zsx94piFr7LYRjPK2Pr80205yha84GW+JqyxveENnB7mXKUJ
         xN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtjXQzgcWPzgMBi/2+5TwnY1V7DI4svnr/RkSpK6syx5kL8byu2kH8uHix8JttOyVe6Vpmlzre3uU7/sDPPGRoDqF8LycdeIBeLqET
X-Gm-Message-State: AOJu0Yx/u+b2BWEUBmV/XY8Gnbr048tFJ1LxsjFf/i1ZbLYcgoASAteW
	1D37cKExBBjwyL9BuYIFfGZN+sIybyxa8agHO9cEmo49Yv088O9QTcIJ+PmnR8JyyuWxqqQgKgQ
	R1NMvFV7wsZOVTc0p2btSKV676j9kC++Aama9NoVk
X-Google-Smtp-Source: AGHT+IFAqX1Alshv376ZhMNlyoqmfCK3CTIFfHANxWb6f1IQokRly5XNKajGW9/04laimT/onO6eb8D0SMawuA9Diqc=
X-Received: by 2002:a05:690c:3508:b0:608:aaa4:8639 with SMTP id
 fq8-20020a05690c350800b00608aaa48639mr660410ywb.3.1708712099277; Fri, 23 Feb
 2024 10:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Fri, 23 Feb 2024 23:44:48 +0530
Message-ID: <CAHxc4buV_UieeVVBhua3vmT2+2e6qf2B9uoxpSPAg6faGBa=Ww@mail.gmail.com>
Subject: tree for the greybus subsystem
To: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am fixing a coding style problem in the loopback bridge driver for
the Greybus loopback module. The source code file (please see [0]) is
located in the staging tree for the linux-next.

In order to create the patch, I need to find the right development
tree. I checked the MAINTAINERS file for the Greybus subsystem
development tree but could not find one. I also searched [1] for
"greybus", but without success.

What is the development tree for the greybus subsystem?

Regards,
Dileep

[0]: drivers/staging/greybus/loopback.c
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/

