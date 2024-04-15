Return-Path: <linux-kernel+bounces-144717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62B8A49A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1301F225BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43658374EA;
	Mon, 15 Apr 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dhgctAVv"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F33715E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168062; cv=none; b=YPrtiu24xD0fT+lFLqEHMlBG9fQoJ3S5ChS0MIJZuC6pNhSD0VGmDo8DcZDzy8uZrVdAcUKIxgUtssd9HYzNQeYauWBMtoYIfR8CatoomfGZ/UuH/wgLzOXB9sjYcQ3Vhai/ZnuHNHaYUk9IrI4/A8q5gdmodaiRRoG+J8zIE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168062; c=relaxed/simple;
	bh=xQJUV7ouw3gjxC/4QwGtHq89DL7N6AhWEQMEzK3rXTI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoEmHghJ0ilTfXdQY7BP69BlMYF87PeH+czqWGvQqjozZsrkgjG6c7OLz3lgco8ZrPGvgS25xC7ZJpsq25LhCVKkwU3NbUcZ6KMwWBH6owG60N4dC21Cd1n4J5HmLrTk+O55moK+TDJRKUYXxC0ZHtnmJoeyemECbDoMIpajWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dhgctAVv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43936411DE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713168049;
	bh=xQJUV7ouw3gjxC/4QwGtHq89DL7N6AhWEQMEzK3rXTI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dhgctAVvwXfYEbZuHted8ElILFWRu73YBPeTZd+HRT2N4oNO0LonicmI4BZkiQGwn
	 rla+g9vLqY8HlTubtdub0Mm8K4rsVVFD+ofxmheCbPYd/qcYNatjkNYcGug+ad6g9P
	 T4GdYf2yYdTh/UEIFuEPPAw27zXUTlK8V36M1pTeiATUveqb4yEU2426JVvA/liD1U
	 E/YJTUNxgG1eRojiiMlE8Geuz6K5GVRKlL0PhX9Qx2TrbY97iKgn8NWpRxTNbUgnSC
	 yT0Zl8J9Gwt7KMzG92a0YEfDJJEIhhnu7oJvOhX5AqU2HgzHHiEnNfdD9q8/XsIbFq
	 lZWoIRv341lbw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4365cbe15b0so23988921cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168048; x=1713772848;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQJUV7ouw3gjxC/4QwGtHq89DL7N6AhWEQMEzK3rXTI=;
        b=liI4IsdlZDdsG34y0y8wm2ZtVqvmc5MZnTrOnPJeRkaNT9PGDgFZQKx0KxR3DBQRG9
         JoQFh4ZA4gtWys+/K+Gj7dUJZOCV/EOh3KSJrKSh3yfLIYVGRNDuiHWXxY1kSQWW60J/
         ySCN6Y1KI19BssO1P8rH/fIZTuBnWzSFXN67UvZKbZvNzGvPu1M5vc6eGCHK2FylvVt8
         ZkmtlRshWyzxlIZsy43PC5ppm5X+o7Q0Yled7CTggOnGfRr/7rldGYUaKzYlM6PmFHvL
         wsEfotq37y4m6HocRZNgyDZDVD0xnSwYejbGEi3d8L+nfd1AULwnzh7G4iINOvwOLv3n
         rYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXX2ZBhaIlKc3voiZvcgMNwc8mZTfW13DT1J+/0bQpXNFlhk8wDdW88LtRWlG1LXw0D5iSxHD97SDjlp3ryr0BNxwoZK+biQYD3IHbB
X-Gm-Message-State: AOJu0YyCup4DTRy8u5I+O3bhIGWEfrlNJCkC+K1EQYtul2ELap3TomOv
	BSLRNp8ZyDUhNsojZKtrgqUHCIyPtN33W3TRsE2d9/yiq644oDDTfdjy4/VYL0c0kva3kdXQ2os
	jMkr36ClDavs/IWtCQjjAIAPFabPPLUC8RufPZKJfPjnLlY6xw98mEPuOdcTVTp0rj71gB5A7Nl
	eLtXkcKOKfSHCQXkeejQZj03FMmkfgD/mUUW+4t8s50EyIjhDVhdmE
X-Received: by 2002:ac8:590b:0:b0:434:cfe4:90fe with SMTP id 11-20020ac8590b000000b00434cfe490femr13506888qty.38.1713168048316;
        Mon, 15 Apr 2024 01:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe+pXzPvCiZ+lTe389fZeXkgPACzxirDALyNBrs+DqUNrezRiMsLv0X/YjDVvPM8e3scKEkXUoepA/ETssmCc=
X-Received: by 2002:ac8:590b:0:b0:434:cfe4:90fe with SMTP id
 11-20020ac8590b000000b00434cfe490femr13506867qty.38.1713168047975; Mon, 15
 Apr 2024 01:00:47 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Apr 2024 01:00:47 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240414163606.2598-1-jszhang@kernel.org>
References: <20240414163606.2598-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 15 Apr 2024 01:00:47 -0700
Message-ID: <CAJM55Z-C_9gsMJCAEVgMjDLCjw2=ArAMHQELqVXAaFSu-GdwLg@mail.gmail.com>
Subject: Re: [PATCH] riscv: boot: remove duplicated targets line
To: Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> The "targets:" is duplicated in another line, remove the one with less
> targets.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Thanks,

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

