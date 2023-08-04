Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03A7701AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHDNdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHDNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:33:14 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9C19AA;
        Fri,  4 Aug 2023 06:32:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-586b78aa26eso253987b3.1;
        Fri, 04 Aug 2023 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691155970; x=1691760770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikm4FSDqyfrLlvitoKoz6UWtj3pz7XBNX80PZSDcqc8=;
        b=Lt5cdLJQGwGOk+MTd1wlB9czMX+9tEcCV1YF/GzpTUQyFgJsqGnAj0RJqbXggaQTqV
         uRwEgGwvxl4ZA1Z680A+HfSkDiRikctVSMl55NwANyDPYQbYe58eq1fCedJTNExFZwJ8
         KcS6vI0rC6wkBfQ/as/xCH6h9pT9j3ITRqx8XjX6MbCJ3FHkwnJjsZA9by5tq5d7H7jW
         +EZMhQAYlABCOfGoUqYLOXq8tuaTr21UsYd3WmWOR5530VrxQw51HYfJGsDeqj9sKd0s
         vKxeCc3gEj7wNtS+tzyG+rjQORkWIyTKXBWXIzThvROvEX+Ck41+qY0gZ5+ITjVJTQFN
         /QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155970; x=1691760770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikm4FSDqyfrLlvitoKoz6UWtj3pz7XBNX80PZSDcqc8=;
        b=Rg44QEl3dVU4jyVO/P8HdG+qdlCe8B/ZEv4Ue3G1yN2lltHvoSPPiOIN+9u780otCP
         9+WTGh7Cs9pu98JgSkFgIn3AMFUAoVbvd+jpy2XXrJQ/D0JWZ+OLHfAQol+XrZ7W6mAp
         sDwh2h6BKXlv1NBAgLcFcAx+TQbAtgSKfecLsy9zIWEwO7W60lhhcq8eyy4T8N0pPjyC
         pvSnqcUUv8syQOnpZaEvkuZL5172dAFaT9Zv/S5VkDukDrtfkYusmx2vrqD6YyKqvthR
         RUa80cPGb38eti5dbUBQh5PGD4ymWOBr3jnrUQNg9gcN7Ze3fyM9d8JHKfQHxpUBpZb5
         5T4g==
X-Gm-Message-State: AOJu0YyCjuk0YTfJo6M3kQ3vUeDhZyDYMYxm91XiAOW65xGLKNYQvbl1
        fJ0xdu2vV+WXzhezst0C7qnPKXMa2cvUK7I4q78=
X-Google-Smtp-Source: AGHT+IFTUo4+bd3eBCObNbXFyO0eLQUgPyrFwdg/ThYek9ub/crmrxKW84vWlURnd1HZy/5AhTmYeUsv5r1d7+p9e/o=
X-Received: by 2002:a25:240a:0:b0:d3d:74b6:e05c with SMTP id
 k10-20020a25240a000000b00d3d74b6e05cmr2116497ybk.52.1691155970059; Fri, 04
 Aug 2023 06:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230804114610.179530-1-nmi@metaspace.dk> <20230804114610.179530-3-nmi@metaspace.dk>
In-Reply-To: <20230804114610.179530-3-nmi@metaspace.dk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 4 Aug 2023 21:32:38 +0800
Message-ID: <CACVXFVP1x7dRfHTFvM7ah9iB41E-5nxp=r16xr580UVJ_PRKUQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] ublk: move check for empty address field on
 command submission
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 8:34=E2=80=AFPM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> In preparation for zoned storage support, move the check for empty `addr`
> field into the command handler case statement. Note that the check makes =
no
> sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
> set for this command.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
