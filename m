Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D827D3852
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjJWMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:45:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622ECC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:45:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6cd0963c61cso1923142a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698065132; x=1698669932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlhwdE4ComxRaEhIsPjvdVHj8Xz3BoU169ut8voWCQA=;
        b=ST80jfvniuf9lr/osqKqZJ9pRhvemJwUenF5JB0iJioQplMdsWTuTZ+rt+saoFgH9d
         9KeQWEFRNcBqup5jTSdyJMNlYqYzUFXl8P6aewf88O7a+Cj6EyYOdINfgEIeNQtTuQtf
         omOWAV9Ub9uoYBTrfI55OWBAyqEkil+WjXQdtkuKgDTl9HM0FhPBJ8QmIg5sX9StTkDy
         7BdWIOhEi9HVHlcyVw7WZE2NDOkfjSs6B0jYulPTTsKjHyptxBAZaVU8/kZo5B11gSwU
         jgXAKOJG/BNzxRxpS/xlFjLi4Apaop5KqbRiRXAVXhTiRWNggI30m+dgwQycsoioPsry
         oyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065132; x=1698669932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlhwdE4ComxRaEhIsPjvdVHj8Xz3BoU169ut8voWCQA=;
        b=SHfjuqJMOgilWxQfcK7cGK0ROzb51lP9EgwCkVLt3p1iBgJ71b2cz/43ETFgtH0f2c
         Az97aPYVX6r2BB6sxeS5QXPzjCLlCu2v0hgUu4iqkhA957NKXOVjPpX3iBBgRVjb2cIW
         ST3zOAFePQT8NKFvCXQyfp+8svDGI29JOafM6CLJbwjcBbV9xsCr2n0Khi6wOcVKgBbo
         5UNCCWYRlFzZspcwaj+HoviTsnkMCs8ONFeyMABp9J1lpfqsTzNBiAsXeJQSmqBX7URU
         8USb7w/05KLsDDhoUAHKW1v3hF8kEaZ2ugZ7vWL826L01wr+Ugj2c8EDdy1YS/FPdJhx
         8NpA==
X-Gm-Message-State: AOJu0Yxmz1ncqKeq5bZEU8mwew820jvOwtR4XcKi2PwyVL5y53CmuCEB
        lqLSyhWXLv6LV5RNapdwLCrHMBC5keStxAcO3SFc3nk/1/w=
X-Google-Smtp-Source: AGHT+IFz7xj139+RSp8fLB9YaKoSA8d1K5jjnkTK4gEJ5zlG8hUHqJuqPH+jOQzWyEzcfRoyyA8QRKNPsQ7iN+LUrj0=
X-Received: by 2002:a05:6830:25c4:b0:6c4:a127:9ff2 with SMTP id
 d4-20020a05683025c400b006c4a1279ff2mr11462088otu.11.1698065131943; Mon, 23
 Oct 2023 05:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org> <ZSq3iuuGy7zSl4sz@casper.infradead.org>
 <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
 <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com>
 <5cd5b88ec8f4500a716aa8b96d27d44e96ed65bf.camel@HansenPartnership.com>
 <CAJHePoayC+RUk4gCCYACRXguuXfeWFvg5cyiCwNi-YxC3-UOLw@mail.gmail.com> <ZTZlvlpQYGsYPHco@casper.infradead.org>
In-Reply-To: <ZTZlvlpQYGsYPHco@casper.infradead.org>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Mon, 23 Oct 2023 17:45:20 +0500
Message-ID: <CAJHePoZZkgVDPy=Pp44EsaSHVNHt1r_tKERTFiDoR3GE3quRBw@mail.gmail.com>
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
To:     Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent the v2 patch. Thanks

On Mon, Oct 23, 2023 at 5:23=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Oct 23, 2023 at 04:08:49PM +0500, Muhammad Muzammil wrote:
> > Can anyone approve this patch?
>
> Please send a v2 with the rely -> relies fix included.
