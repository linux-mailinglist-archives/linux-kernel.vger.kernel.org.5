Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FD7BBE44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjJFSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjJFSCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:02:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C26B6;
        Fri,  6 Oct 2023 11:02:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41959feaae2so13897501cf.0;
        Fri, 06 Oct 2023 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615335; x=1697220135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5nBRHjJ7WNIwX/8d0eZMyTygIO0HnzObi9iT1OLYIM=;
        b=AU5JP3nHi5QnckZgfp8lMAaOAXuF6sjQiIgl+cfJgPOn65KvtKSY8T9Cwz4jtzqgXF
         NKQAnSB9qK1Y6B/Dq8AdT1n0bRKhTzYFNKfLKXQcQJRvOpkDNumDZfEeJfTJ0uHxKxTk
         kp42aPG+1X5wCCA2Mcg/SS4+oLsREPVWtUBl/BZCA1rPVogrMViL/xaDET6esm+tfS2W
         cZjeaRqagDM/HCxEjcw6ic3qyqZ2Uwbd/yzGknGp2LuNKIx9AeGEmV8VCpRpzeKJkUuA
         bYGf0KU73MA4eEplsG3C3jOeh2a25Wa9ZJh3cOXC0sBL5VvjXAsV+xmfHLMv6ShvYkiV
         1ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615335; x=1697220135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5nBRHjJ7WNIwX/8d0eZMyTygIO0HnzObi9iT1OLYIM=;
        b=a7bGZSR7JbJ9/s41sn+6eyTsXu4ffjvad7I3jaBKwjfh+ECFa8f02lzJm1HVdYDZPF
         gKtwI2+OdVKRn6M1LnmE1dKnF2wO6Z2+k3ykc6x+zgOF0NLSvsUfsyqAJQeO/xk/uDJn
         JGFyPRdLFXuObQ0eYaOwy3p+eMa/GFD++7FZU+5pkhFxcF/DOLSoLQvl6L6e2SC1xj8y
         JFGVdesrN7TXxhHXNO+TH/t5B4fbuRnnNCIBxv3fA+Dqv/HygoxTOYHsUMhcPfgSPFkR
         RPNi2dVDnKwOraqBCLpy5s0o4nSF3aqa4B/GfJuLF+gpAvrsoRe0SvzctqRb1PUwhYjG
         pj2Q==
X-Gm-Message-State: AOJu0Yz83pOg62DH1kFw/vADU2PniveRUjZ0raCs94andwQIRty8Nvv+
        YcXRA8wqaQfdnB6sTXcRpkq7oAGSYZPudaScDBw=
X-Google-Smtp-Source: AGHT+IG43kEbad57pMEcbcdJC4BEbpSUZcJ3CXfQlHtkDtF4VOejAo87tZGW5bfydss0IWxVdkp8iS03i5O4rILgKUY=
X-Received: by 2002:ac8:5fc5:0:b0:413:5d52:ee17 with SMTP id
 k5-20020ac85fc5000000b004135d52ee17mr11080318qta.42.1696615334952; Fri, 06
 Oct 2023 11:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231006160437.15627-1-ddrokosov@salutedevices.com> <20231006160437.15627-8-ddrokosov@salutedevices.com>
In-Reply-To: <20231006160437.15627-8-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Oct 2023 21:01:39 +0300
Message-ID: <CAHp75VdkBR5yNd-U_v_4fv2pHHwzKBg6ajnZgjw=xb8kT+y7UA@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] leds: aw200xx: add delay after software reset
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
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

On Fri, Oct 6, 2023 at 7:05=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> According to datasheets of aw200xx devices software reset takes at
> least 1 ms so add delay after reset before issuing commands to device.

> +       /* according to datasheet software reset takes at least 1ms */

Please, be consistent in all patches in all commit messages and code
comments on how you supply physical units (w/ space or w/o, take also
into consideration traditional scientific practices).

> +       usleep_range(1000, 2000);

fsleep() ?

--=20
With Best Regards,
Andy Shevchenko
