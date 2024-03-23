Return-Path: <linux-kernel+bounces-112227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E3887726
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E934282226
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E63453AA;
	Sat, 23 Mar 2024 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zhj0itvl"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265F522E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711172879; cv=none; b=oDlZTB6LMqgHzgk6F0SGcwqz12dgskCwaqswT5QNLNzoNPxlXmpGlGOOd4JSy6dx3/uDIPSVlik54HAP/kET+JZdxFgricsBHeAUJUwzZPKNtYzgOh0ZDQJJ6xVyquUWkMdhNKJdJFmkZvjNpmF5XhV5aZcworj90q0w6wc9FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711172879; c=relaxed/simple;
	bh=QAuGX3tf8P2TdpQEsv1SIpFMKW5zutY6rkbdp1V6ZtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo1Q3hyw/ctRj3u4Zraugec3ZGif2K6yAClp3TYicFFbsFXW1sxXQd2fExSIDpqBvOBbbRGgzTtvGIfIGGmuZMBCJP8vtiGzD0CYhlnGI4CV91P4ibEzqkOpYTlZNJ8uMGNh1Pm0oPq3lJ0mPZfgdVgjlhP1DosOB/GmeCOj2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zhj0itvl; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a5272035d3so494869eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711172877; x=1711777677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAuGX3tf8P2TdpQEsv1SIpFMKW5zutY6rkbdp1V6ZtY=;
        b=Zhj0itvlBewl4t96nyU9+5BtWMNpMFXKKUcdFiJjlt1vBKjZZ8J1jalcAEh6sn+8Z5
         lnAYsw0WCJ63+ADBo2rLPyj86ozk5BUOra9Ft3l9gi9T0sX/g95BADBw2wpMQXI0QSTo
         yz8xv0VS5mqVp947JNNniMAZMmbMrsiF5LKIwbduEI/tq/LU9X+TMvG/+GWXfw32p6yg
         uvMM1GcSuCYwjRfqlvWbF1KyOnDUABtqo56PuShzGuL/LEEdgdHoVqg9otJOIEXsmg53
         mtLklzSTIzF/noQmtRWOqrQLE2USH+w+B/8V/+Keb9cA012/6hAAW9OsNaYtnVQLSw8S
         mBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711172877; x=1711777677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAuGX3tf8P2TdpQEsv1SIpFMKW5zutY6rkbdp1V6ZtY=;
        b=m/LjEMtgTd0gDK/oLM9odZJqIbwcjgWY2h93H8cRmr9Va6vVEYDp5z6nbOQolwZWH0
         uxGt10rjx6IBIuEa6ao+t2lZSSLZ+f3GRbrI7dp/qXEiAgu1Ravb2Sh9/8ryDa7IoKL/
         K9MqhFlldYxChoIjyeH+IScvJiRDrUkfpDEe4N+IPLt7Hgix7psc3vbuD106v+zpmaXU
         JnY4xm79ydagWwGkwUapx4SwZTIYxsATdicj5wRSCs4j3SBehz7CYV+fmL7bcduHbkMV
         I63L6ZBlYzSHxcVhZdARlLgIocjD8lLbpqzit6kARiv5VOwtcW1WSV96wAdV81ZGbKpJ
         ff1A==
X-Forwarded-Encrypted: i=1; AJvYcCUPUx+odA5CuUKJ7MUj1SjeTUfNfHzyMglgJMzDK6N5PM9sAtX7iF6z7Rq4zaPnPyX28i5xo7+uKijFKVzV5Dq4ZXN/nmLg6DKp9t5M
X-Gm-Message-State: AOJu0YyoQcY3I6ry/0l3VrQ+IWAcU7MKfqI6lQOxw0Sy5mFjSV1jHBe7
	NF53r87HlUfPWMuXDpYGlyIvXW4KTZPLzOlfkc0mEwuXpVxCQWEij/UtSUaZ9YC1YzSjPvVtyEd
	HRYAQ8BV0WLLqWm0WcNKfu1fJZlEWgf3dXBE=
X-Google-Smtp-Source: AGHT+IGJuQX2iGfuUjborXV2RXTg4cvlqOj6eigknOA9Nw1r0mqmWiyMuva8xs8W9i1yeBUydj/AAnpRWkrzLkF23Vw=
X-Received: by 2002:a05:6870:818f:b0:21f:236:a316 with SMTP id
 k15-20020a056870818f00b0021f0236a316mr1914018oae.50.1711172877419; Fri, 22
 Mar 2024 22:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfk0UfLh3rRf6qDv@MOLeToid> <Zfs0+0C7nzKiBjGy@aschofie-mobl2>
In-Reply-To: <Zfs0+0C7nzKiBjGy@aschofie-mobl2>
From: Felix Kimbu <felixkimbu1@gmail.com>
Date: Sat, 23 Mar 2024 06:47:46 +0100
Message-ID: <CAK=vLx+bLg90jgWouqGQ8itsEsp5VNeV8tJuEzZHMm-D_0+bPA@mail.gmail.com>
Subject: Re: [PATCH] staging: pi433: Correct comment typos in pi433_if.c
To: Alison Schofield <alison.schofield@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:11=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote
>
>
> Hi Felix,
>
> This commit msg and log can be trimmed. Please take a look at samples in
> staging or here on the Outreachy list like this:
> https://lore.kernel.org/outreachy/00be5f2a97b0c899279bd8f9cd27634186b77b9=
d.1666299151.git.drv@mailo.com/
>

Greetings Alison,

Thanks for the correction, let me fix that.
Regards,
Felix.

