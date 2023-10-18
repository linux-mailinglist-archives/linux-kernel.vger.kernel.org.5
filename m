Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098747CD9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjJRK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJRKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:02:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137695
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:01:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c53c5f7aaaso22372251fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697623317; x=1698228117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm3UeWzK8TpoHkqcRCHm5SejEBJ+4uqDLzPp4E7NGlE=;
        b=Ck7ftcBBh1Xp3Juvnvnuer05MNfg1Ju1OahGJThIPIlaF+rcagIndRs6OW/1CCzWMa
         dmW5NvAINg2z4taMV3XRAnkhmv7auyOnGBtrhr4Pgzdz5ZXxsM8JK2ibhjXELNukXCHS
         i0XxhivPGlD8ae2eA6wO6HaYM93YpRN4F4m2jt1NMy9cMzq+aYNBTTxCLsdYvQCoozMb
         F3TVn0Oa40z8zHsyFxgKHteVxxZvw39lcM32oL1fInhZEapIXzrvy3sjAyHj4YY+berD
         DL0x24TR4ifNljVbDb9XzDsCWcunj/zN3UYHO9eH+J02RmFmZbzhj6/htEqNKhLw17y9
         0FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623317; x=1698228117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm3UeWzK8TpoHkqcRCHm5SejEBJ+4uqDLzPp4E7NGlE=;
        b=PC+nexnosc1CKuC7N3bS977E5AYRFWlw9QsEYOjqw+6b6UrRFtV3tTwOmGBijgtEDz
         2i4yjHbiCzBudVPd6JGcs8DDIc4uhDQcd+Tm9saKmsphbI1gNFso0C6p9Dg7QjUEsE+D
         EgQH0zk21NtlGxhwvu0c2QEb48ZkmDkgGQFzSGF0HkYdd1IoeyUZie8tSx+f9ngJ7Nwt
         fipV778LOqAgi1e1iAwjmIA/nCLiXhYsu2pS88kLhsEMR8msm1hkcVKXiaRpqLOEeEgV
         V4WurehvEZMGcicJYjor43E4n7qiGRd/2VcATjARQ8etJi9uHu+iPrwed3Rel2TbB7sD
         F4CQ==
X-Gm-Message-State: AOJu0YxgtBYQmvbyb5rAOMf1RWJZOGpqHfqJQEGDJA66ZPagURV4kO3S
        hEqxQ/0pflzKjq16LakHyAJU754FL5JpWOIjdxg31g==
X-Google-Smtp-Source: AGHT+IEVIW6QFRaDzHHVooodWsrl0/MQyTjP0WZTlWCzYon7LZ2rIDdVEwwxlKa7291h9eYtxaO3hC0D5xVVI5sk9vQ=
X-Received: by 2002:a05:651c:1989:b0:2bc:dab2:c7dc with SMTP id
 bx9-20020a05651c198900b002bcdab2c7dcmr4347563ljb.47.1697623316974; Wed, 18
 Oct 2023 03:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <202310172247.b9959bd4-oliver.sang@intel.com> <2023101759-front-ember-6354@gregkh>
 <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020>
In-Reply-To: <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 18 Oct 2023 12:01:45 +0200
Message-ID: <CAKPOu+8r1QpFUCyMMS04GOi-+HqM7-dxR4JcoLXfvXARobbZDA@mail.gmail.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:07=E2=80=AFAM Oliver Sang <oliver.sang@intel.com>=
 wrote:
> it found a (very big) regression comparing to parent commit.
>
> 19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   12433266           -99.8%      22893 =C4=85  3%  stress-ng.splice.ops_p=
er_sec

Oliver, how is it possible that we have three times the throughput
(MB_per_sec) at 1/500ths the ops?
