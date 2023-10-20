Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373447D0F52
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377327AbjJTMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376985AbjJTMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:00:44 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9C1BF;
        Fri, 20 Oct 2023 05:00:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0760cd20so6425896d6.0;
        Fri, 20 Oct 2023 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697803241; x=1698408041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIKXyvCrPlJkXSUN3jOs1qukwDq8mum31g8U+4d5eTo=;
        b=D97ybIEXSVA15Rge51qeMBeTpfIhQoxywOQjYG4OSukdRNPjuSYzkvOSuFGIwkSfdm
         9B1hO1XguATAWmFDgSnEGfM4bpJj55Mx7+a8K737vh7K9Wz8zvngOCUSsezoFk3aMmgd
         y+ucWF+qlLs4Sd0w85c136a8w6yq29TSbiDHVZPw0OqIZEZuFoO6L2C4Uk/ffJIOFqtn
         qhkjOJKXtSDgY6QXEhQxMl1ZrLhbFBik/d18CNalYtdDUUKscY5Fj/9BnUOGnpFy9nbT
         1pigVFCbOc3o/77/DLgNmtmD4LtcF5Iatr0sdF6j0HaFHzh1sqNCxu1UyV7SJYedIStZ
         D70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697803241; x=1698408041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIKXyvCrPlJkXSUN3jOs1qukwDq8mum31g8U+4d5eTo=;
        b=kU9qPx5UqcWFzicX2owacFfO0YPQnxgYg9CCc8+MELvoLP+2QynM42mU0EvzIce+qO
         tWaFSwwd9voQNq1v9RfjN3led/nJ9eTIRkLnRJ8GmBYN2HKGiEVyFdBPb/xNytL6bQ8g
         cSngVnMJr6nw2kkzt7EyMf4ij+mn3TJI/OBBH8mEzgWeu61/PY9mzt2BKiw+BZ3AfR35
         mOFQYnUFZeifWe4MgaixTSfTX1Ou0C08A5WVPtaWgkMg5hZuqADf//u6QN4v8b0/1h6o
         TYvhwCZp3IBrdnzK02zUvw9Yiq22HxBXjPA8RkKhgPOuVs8CIusyHQCln0/iRPx5O54v
         Lt3w==
X-Gm-Message-State: AOJu0YwUUXzYUqMgpgLsL5FNOIn10U4Q6qDxZ1ACYex9Y5cuV1XrN1KI
        lqDehLYFgJXiHcfrHiDPKDLjHmofUMdhs11AjGssda2d
X-Google-Smtp-Source: AGHT+IEPBLT7eZYqqWbTCOeDeMYDZ5Ubq3VZnMWDfjvv3NiAJGXOoHIw9t5KJMBFN666SPvrtv9GAD+Mqs5ZmrttVhE=
X-Received: by 2002:a0c:db8d:0:b0:66d:78c8:262b with SMTP id
 m13-20020a0cdb8d000000b0066d78c8262bmr2151113qvk.4.1697803240827; Fri, 20 Oct
 2023 05:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231020092735.2565-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231020092735.2565-1-bragathemanick0908@gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 20 Oct 2023 23:00:28 +1100
Message-ID: <CAGRGNgXaKWS_2pfk1BBf2s3JZ2yF2v8m57VkZ_WgjEHGBzgmXA@mail.gmail.com>
Subject: Re: [PATCH] b43legacy: Removed unneeded variable in debugfs
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     Larry.Finger@lwfinger.net, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
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

Hi Bragatheswaran,

On Fri, Oct 20, 2023 at 8:27=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
> Removed unneeded variable. Issue identified using Coccinelle semantic.

Coccinelle cannot detect unused code or variables.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
