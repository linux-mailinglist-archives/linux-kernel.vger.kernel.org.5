Return-Path: <linux-kernel+bounces-23362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91E82AB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF6E1C23971
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EAF12E5A;
	Thu, 11 Jan 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td+xNZv4"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240FE12E47
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4230610276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704967708; x=1705572508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zps4PpI8OaSz9bFumvCqbmdTj+6HsktbWUC2QnoS1I0=;
        b=Td+xNZv4y5b9IoiN+fbK12/DpWjWtry8Wy9fOitlq9gKupxOIp+Hfk9Gw/xfMY6fYV
         6ZBIchVtHqtJa4iHCvneKYJxF5aE8Pzec2JuhPpyveERZ5naVBCOSgSblGhF/we+l4O4
         DkBwWl1MQPX/Cqt9q0DHOJpf6+7VymNNUQSBfcLD7kR0/y4QI0tzifh5ZqGqY9B7gWMo
         FOh8VExVQrkGgf0Kujgwqwey4YhJtS77KErnAKEA0bDJfu9Mv3+73VwfUNABfr0VDnqW
         38mZoH89Wh+IazF5yiI+3q3rxs2+Bstic5xDrlD5M3Ui41YU053du/O+ZK5/S451ISEM
         T5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967708; x=1705572508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zps4PpI8OaSz9bFumvCqbmdTj+6HsktbWUC2QnoS1I0=;
        b=R4bdphG0j/olCXxRXi2Hf2WrhYgLi3/qT4fb1lnYMqg0TYRsJClpsrmbrvJNjK9lFp
         r7NE+t56znokwylKbu7V4vbFYLKcqz+bpwCkwPGcCeLjHrmjALKF3rDyNvpD1U0qcdo2
         fokbXnL+1w7MVcWtfvqy1w/IC2ZLB3qAwmQIfo+WKnmlSLoRqLclOrUMjaNS37vXoQdc
         aa2mi7y91Kg2BCo4cjFzPmw4IbZ0aQcXDJvEfGA7Sve/q1zNTZ+Fcu+wsulM6gLQHnxH
         NLPVyoB0m+bCZ3oCH+Yc72zeXGu6f/ZGPql4l/VZWDRdFjo6kwPFihxht3/+djdhZyX1
         ncVQ==
X-Gm-Message-State: AOJu0YwBATwMDWXjGPcjFzIA7YqRCQH+nUSakeTsOS18yRryCXPvSyLi
	HWoCUrB/vOKQ/vpgPjaJlEKT0HZuE3KL/yZWhDU=
X-Google-Smtp-Source: AGHT+IEc6EgqOT3zTVEg2np101S995ycMLJ/8Szd+uMjyBhwO9sz6YXT+p1w2VTbeLW3f1iFxgsVuKsew3azO7AfTt4=
X-Received: by 2002:a05:6902:4f1:b0:dbe:a6da:204d with SMTP id
 w17-20020a05690204f100b00dbea6da204dmr882032ybs.81.1704967708072; Thu, 11 Jan
 2024 02:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111070652.71717-1-pranavsubbu@gmail.com> <2024011144-silica-viral-9e79@gregkh>
 <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
 <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com> <2024011144-sinister-baking-952d@gregkh>
In-Reply-To: <2024011144-sinister-baking-952d@gregkh>
From: Pranav Athreya <pranavsubbu@gmail.com>
Date: Thu, 11 Jan 2024 15:38:16 +0530
Message-ID: <CAP1Lp89zshQW_s0eLJjekr5tyc3XLaPnh2VGFrNDHTA7GT51ZQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code blocks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Forest Bond <forest@alittletooquiet.net>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 2:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Yes, please read the kernel documentation for how to submit a new
> version of a patch.

Reading the docs now and will send the patch right after. My sincere
apologies for the top posting.

Yours Sincerely,

Pranav.

