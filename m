Return-Path: <linux-kernel+bounces-103536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C851287C0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655EC1F22579
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200973191;
	Thu, 14 Mar 2024 15:59:08 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C56EB74;
	Thu, 14 Mar 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431947; cv=none; b=qA0dzEaJcTisWZnitxah/hjMqC+Fq11xnd00GEa+Zy8VW4D67E6633bB0LOnWDRAIClzuskR/bmYKtuM8cM+zX42LXc1lKzcRtgiveyx6NcPiS26omAxwjbXi3MY8r/friQZXyZv07w3l270JTC8/JHoru2ACdTS7dGQDyukRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431947; c=relaxed/simple;
	bh=qLm7sdMyTp87kkhCt/5MhF2kdOOR6nFZ2M5qYMfYhE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J26fjwqAnZX6f6QkgDEnQ9/mOBhVqqXt1+f06EKrdEZ6wTxTlTSmFSAj0Ql4tNaISwTdffIuvP9DdCQDs0rGpIW2+joGhtUsZGf6FWpwwWOlJN3gnQ+qYkUEpG5v6Pvd/h1pzVExn26iStiDR1DEEUkC4o+2I6WA0ISt7PX97iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60cc4124a39so11309267b3.3;
        Thu, 14 Mar 2024 08:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431943; x=1711036743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGo5y059xssa9oMgtCF+hT1vb68q8rGTMUHno6LSTBk=;
        b=FFuNwaqo4NpZErGsUumZa4cIh1IA0ICrZqyltAH8bUZLhv/HI5e4cLxfmUabtoUvjs
         oGkdCLywOIwY7+/thWo3Sm4ErYOjsBiobwpRYOWIOWGLX8OsJmz+AvyvbYizhGCvHpvc
         BrTE4oTIk2tWWD3q1aHuZwQpT9xpJ7psLiXwT2UH7/hQIxoZhuTw4uYRJwajpqcBOGUK
         Ef8x1znICqPh0s3V5mqTO0vqdPr9/uu973/CGamsSt1LGn637w0Cw4u3ZOjX1s2/pd5m
         rTa8zB1nZsr5fcdkV+pw9MkqzUnjyC7S46bYj+TK72Z7ZCqjU2UGIxU3j4pHJ8VVhhU2
         O+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCURGXGVV4B731YJ3lv786jVh7JUr5BrzXcqEFoh3UUmLzUKW7tp+LjibGNJbWv1zfXyhhOBbEAd4Q8XXCrphas8zNeUJfgMpXEZKbQEFIlFL5Qwytlp8bXfA/2mm9ZUUNaEtTm+tFhTvVCvl7YuA+xh86Nj8UZDsWPV0v6xqqLQxPqfqVr3b7RI5Nb+jjs/XITlNlEGSmO6zoK6J5Nv0F5FMy8wRd/Y
X-Gm-Message-State: AOJu0YxO64FkWBSw4xsKWfYAjk405XOisJveA5zC8OI+VNXjy5SspEUj
	nOAD93asyJkhxDLwMCN2dKnoTiayTd1agZPvD3NV9obpu7DgFgT3emjLhT9rm/8=
X-Google-Smtp-Source: AGHT+IH3mWZnB00yzBl/P+4vpCgvy1TqognMcOx1eiqXCS8bhJRS8l8FzburGf5wIcSmP2v0Dja31g==
X-Received: by 2002:a81:89c3:0:b0:60a:1e17:2623 with SMTP id z186-20020a8189c3000000b0060a1e172623mr2166957ywf.51.1710431943646;
        Thu, 14 Mar 2024 08:59:03 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w64-20020a814943000000b0060a2c381287sm325163ywa.125.2024.03.14.08.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:59:03 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609eb3e5a56so12810697b3.1;
        Thu, 14 Mar 2024 08:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCHolDbsLYXxjJEPZCH1Wmwn7mxZRBqJRmKOvt3cY8Sa+cykDHHC6TOXUiUFwoAYOLmwNAwn7q1xOSveluKR5xYclrAYOW7ULEtlMVfPXpGXHIttjtK+EJBoyDl9mmX/azL0tL/s+FhH3OEZclR41pEu1aIyM0wkCE9kYiyLvcB39L+J5SaGqXzVt0Jr5RQwLG6OxPLm7Lc5eMNlRAjXYl5h5SrnM3
X-Received: by 2002:a25:8541:0:b0:dcc:d196:a573 with SMTP id
 f1-20020a258541000000b00dccd196a573mr1902447ybn.36.1710431943159; Thu, 14 Mar
 2024 08:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 16:58:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaKF=4Uu074j9X5Q62OsDZ7q0tXaFazxTP5+TFD51hEg@mail.gmail.com>
Message-ID: <CAMuHMdVaKF=4Uu074j9X5Q62OsDZ7q0tXaFazxTP5+TFD51hEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: clock: r9a07g043-cpg: Add power
 domain IDs
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - added "RZ/G2UL Only" comments to some defines
> - added RZ/Five specific defines

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

