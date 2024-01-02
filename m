Return-Path: <linux-kernel+bounces-14676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047482209E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0181C22665
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4E156C3;
	Tue,  2 Jan 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EY/Y0Lsx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E48156C4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso451a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704217969; x=1704822769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JnUuY4M9qtYjhHx0d1iAoLibQlRjERDMsDTlYJYQ8M=;
        b=EY/Y0Lsx/LX3w0tHUEzBosK5OAm+faPDVBPdgJRDIHMEj3BlGQJAgpGBIrOyomLWnG
         0ZlCE4+gsP5APRiZoJfYLQahQEm0PjptYwOGl6y6r2m693U0BdweH8eLlYY7iW43LGnU
         cPX51Vyhe5q8sJGFJao5MWGiFU4xLqXCRVLpOtdGycFPDNRISVyTauq95naM+IcCOXcB
         g2cdwR/d7DC4OsKH31A5nA6WQG14ZHOuTbQ0sHy8n5ZGBwcfllQ6CQgSQSQ0vZK+qC12
         BewYjCfnEB1EzFtHWo7AMLVSFDeaA4mckNBa97cf8q0WpaIpoxDrpFWwJn4x+yKpMhfa
         HyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704217969; x=1704822769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JnUuY4M9qtYjhHx0d1iAoLibQlRjERDMsDTlYJYQ8M=;
        b=tfM7QSKqBf1ORQK+nfD/65kOzoK1iqVp/QrnvXnwFYiRJbKasPzq6K8UjIcQ2CCHfM
         OfMOO36L6xMPu3dzSnoBImVHv9MzLZqibtKMG4AQn1KC2QD2giUwaXbyaoShtzQ4YlOO
         0Tf2gJT3FOvJHH7VwbJ9Yca+duerkmmfhTP2GxFieNITVvQvGGcxGnEFzzpMVl/dmU/U
         10QIeEnldbgEYsU8PQ5BDBVWNX9q9UG8KPOiEZuIK1YidMjGBx+cjOh/M9eHX0+obIZY
         9fuJd+hHOBS6e7gVjprxwv8YLvfZXpbLvnrlrX9U+DdFqYQQvMD5RVl822lU1OqFqUjd
         KM/A==
X-Gm-Message-State: AOJu0Yzaf6yrpCVzvu4PGSh6HCQHofSdSTfqRNXWrc4bG3L9dCzP3nGP
	63w/P0sE7+3rCdCEgzR5uoWLgoHVd76ht6mqaitWU6wcG6ay1rD9y9MuVhl6DA==
X-Google-Smtp-Source: AGHT+IGJ8BljJDaR8vES20RJvWnVVKHpcEdOyIkDvu7Zquv42tGv2FUyRLJO1xoWnnm11TEHAcZptWjqCPHedXIlUGU=
X-Received: by 2002:a50:d705:0:b0:553:62b4:5063 with SMTP id
 t5-20020a50d705000000b0055362b45063mr1136137edi.4.1704217969561; Tue, 02 Jan
 2024 09:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121203954.173364-2-rdbabiera@google.com> <ZY7mgMkoaZDZGua4@cae.in-ulm.de>
 <ZZO+HZjR6O1eSyjv@kuha.fi.intel.com>
In-Reply-To: <ZZO+HZjR6O1eSyjv@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 2 Jan 2024 09:52:38 -0800
Message-ID: <CALzBnUG_8d-PLdhpHb4=mWUZ4oUguBqj3hBnE_HBHgdX1WoyVg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, badhri@google.com, stable@vger.kernel.org, 
	Chris Bainbridge <chris.bainbridge@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

That sounds good to me. Christian had proposed a fix in another email thread,
so I can post the patch after testing on my end.

Thanks again Christian for the analysis and fix.

Best,
---
RD

