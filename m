Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B597D2321
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJVMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJVMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:52:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EDDF4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:52:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9bdf5829000so351725566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697979149; x=1698583949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1aClNsXLK187CY4ojVpZL9A9iEoN/DQ1EdAkMF/4MQ=;
        b=O1QJL8NfLArnjwTqz9wHWPi44EvCVIISL0lJcKpszkVuFIQy7h7dMBSHBz8XQps/94
         ni/94JI/1TK215GA3rdEG5BqAmtd4saJh5Y64LV76Rv+zvrYHoEJpFW5wmIoe/zf5Uct
         GDkEmaKngk8JWCnJ1Hd8qtXU3XO1URPTNyiv6Jbp9L5eYCN7VGSJZ6fXvg1bBZP8Fcdf
         M6yOEWDpVtK8siAb+0HLwK1MPgtfIhKQbezHZyhInQOJkWAZhOoIizOFi91w2G5g3oj7
         JZcCfbjgbV1vYMaq+48p9tcY3aK8oBm7cgfXOdnC9DTtfIljUKVKaAx3pqIde+qcoARw
         GXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697979149; x=1698583949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1aClNsXLK187CY4ojVpZL9A9iEoN/DQ1EdAkMF/4MQ=;
        b=kvkuWDVoAFV8nn/sL6gpcNjWhVMDSjd6AojPGCf3h9zM0z8fbAERcfJNnNm8YPPNzt
         fYBgoz6QgC1pVxdEblZViGdQrc1G7SzYcqQfwwOOJ4YwfX65MS6Fzm11qHiPmrlDJOeO
         0lDWI/4uYnOxCKqn1xqCWErb7x0Axeg/7/SNyMSSl8x1cDC17SsF2M7s3PvUoX9tnnky
         DCXZAD+9Oy/ChMnh4/Z/W5aJzew0V6XneB0h6Hdj7G1gHXeFO98C8DU+sqQ/ip+xhBcL
         FpUQTnPJP2UnAjvM9g7mb9RKS8INUzFlCUgFs+38McVKc6rCfsyFEP3dL7MdJmjqtUWB
         m6eQ==
X-Gm-Message-State: AOJu0Yy1YwFdJTJgZ8lJXImP78bFWmBKXgr/vmu+dOY8ttZyD9JYk0NQ
        s0cBP5plxi7CdiSxZwY8kwkbHm9lPeY9FGFWAMHNU6sF
X-Google-Smtp-Source: AGHT+IG7MtwIVuiMObFJYyj/BWZxLS+aIt9mCsiXjvMHs7aZraZp617ZMAtvkqeKKj+2dm4M6Uyccz9VcXLP/a5GvNw=
X-Received: by 2002:a17:907:72c5:b0:9ae:6a51:87c3 with SMTP id
 du5-20020a17090772c500b009ae6a5187c3mr4151059ejc.9.1697979149385; Sun, 22 Oct
 2023 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOx-CDV52DRTmrZ7WEYxngCTpO-X7-H4PGXS86xC9vDJU9U94A@mail.gmail.com>
 <ZTUGCWr0EgAf4I4C@debian.me>
In-Reply-To: <ZTUGCWr0EgAf4I4C@debian.me>
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Sun, 22 Oct 2023 18:52:16 +0600
Message-ID: <CAOx-CDWB+QQLyKoSsH=_HfwRBvOeaKKN2v5kAKpr+TgsE+zhDA@mail.gmail.com>
Subject: Re: How can I get/check all the kernel boot messages?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org
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

I did not install any software. I just booted custom kernel from
/dev/sda3. In that case, how can I see boot messages?

On Sun, Oct 22, 2023 at 5:22=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sun, Oct 22, 2023 at 02:48:37PM +0600, gmssixty gmssixty wrote:
> > How can I get/check all the kernel boot messages? After booting, I can
> > not do SHIFT+PAGEUP to scroll up to see messages. Also, how can I know
> > there is no problem with kernel booting?
>
> Run dmesg as root.
>
> --
> An old man doll... just what I always wanted! - Clara
