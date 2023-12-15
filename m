Return-Path: <linux-kernel+bounces-683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE4814473
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522EC1F234F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9881802E;
	Fri, 15 Dec 2023 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC/YVVYX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522A18AEE;
	Fri, 15 Dec 2023 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33635d11d92so214936f8f.1;
        Fri, 15 Dec 2023 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702632606; x=1703237406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79zIBD/UbRI07OJHltfEg+QZ50+Tf9xaWKrxNDztd8Y=;
        b=BC/YVVYXjg8E6eGlx7EK7/GdXAJzt51YX77jotQe3MiYoCF7NL4InQ9jE9ypMaQJBy
         GFes0g6hr451Vovm7U9QPstS7kTIxEga7hta3TNMuzoRmjHbHV7RwEem45Oi8n9i37z4
         KHQjEZtDJ7+reVMOvDjUolGj2YGm/HtirmvQB9AD8WcdFExgzJV+OnDr1GTTIiABxF72
         +SWPC8sNP6Ked4eAVTpNHT7w08YLK9goRQZcH2pUGw9a5X8dPT4RaLpr702qApEULRbn
         stDK+IvDOG3ONZiXtHhT+3T1tlm7Twv6oOaxZK0b1glwnuqjFJXZvT23NIxuN2papMv3
         /ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632606; x=1703237406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79zIBD/UbRI07OJHltfEg+QZ50+Tf9xaWKrxNDztd8Y=;
        b=Xk4x+A1rITqLyxYGwC/Ed6GNXeBQuSf29tKZVJiHIPGrW5FL4VHArtdhL6ZnFyaCDb
         vRYNdjO3+uB6nPIC9RJekEN0iSLvWiVF54PWVWZX6fmzW1UV+mvGV4rIlG3abrbfDLcn
         fKww5ACH3U/uuF3bYrsqdQyMr21vWxoUTDkuxDu35lLJQqkMovrg1YogBKHZskhH6Jad
         RT7mHMpwN+BJvy7wnmS/ib5JQ0TBqgFgbwEwRo1Imn16ff35EH679hDFweIsz+iztLZ8
         EqyyASnxxBTAdS2ejlj6pNXLM/jqa9AW2qMAnsAIAB9N6WvhLM0WPJlWcaWnrCeSXtQj
         sm0Q==
X-Gm-Message-State: AOJu0Yzyf6klpy6MHUX+y5S64I011z9EmIbJzvgJ6G1rHsMzWXKA4FS6
	DW689iREB1SXZKMtbRtcO2WMUVZo3IoWuour5ZI=
X-Google-Smtp-Source: AGHT+IFj9Oxq2ZNCrDN3sSVeAs7luB7+TOGeuBPoBWPEkMisMgUlrt9UE0OuW0ZNoImUBtwhT+KCmSsbUoqwCS0vefM=
X-Received: by 2002:a5d:4acd:0:b0:336:4939:2c97 with SMTP id
 y13-20020a5d4acd000000b0033649392c97mr1343786wrs.47.1702632606414; Fri, 15
 Dec 2023 01:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130205010.it.412-kees@kernel.org> <CALk6UxrWjHAfUXQZF4UcA-iwW92gpmfc41LBETC5_wDXn4zWww@mail.gmail.com>
 <202312041410.708A1416AD@keescook>
In-Reply-To: <202312041410.708A1416AD@keescook>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Fri, 15 Dec 2023 19:29:29 +1000
Message-ID: <CALk6Uxo8GYBpowV7osvAYZaGMAkVVM+spdCv0rQYgVntbxQO5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
To: Kees Cook <keescook@chromium.org>
Cc: Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:10=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Dec 05, 2023 at 01:46:27AM +1000, Ronald Monthero wrote:
> > Cheers Kees,
> > BR,
> > ronald
>
> Is this a "Tested-by"? :)

Oh sorry Kees I have somehow missed this conversation.
Yes ack the tests which were earlier causing oops, now pass with the 2 patc=
hes.

BR,
ronald

