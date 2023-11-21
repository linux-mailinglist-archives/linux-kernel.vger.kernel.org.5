Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D797F24E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjKUEqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUEqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:46:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B522FDC;
        Mon, 20 Nov 2023 20:46:10 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7325103e87.0;
        Mon, 20 Nov 2023 20:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700541969; x=1701146769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caEKODLYD8G56ZBu+Ji81b5D6XsHS3BHDDu1vj7HIIk=;
        b=FpCbXpl3Ny9Cd9b7d7Nxx2gUr0n3BrVd+SguUUkA+9kkZ02/8P6abmxGPD+GQgNoZ0
         cvUjjSVePg5EP8mLv2+sWxAM6Muf4yJb3s2unEVZm7fkr47kikS7Um5DUlTvkdMvMGal
         EK/IiBcjKv4NNWCNh7l1scX3Pcs8dVBQtgF4hzxvTizWIh+katcE42s+Hi+kWcUXftZ8
         erDYk/PCJl/QUqrl3OLLoprZrb0tbPBCPY36xTbH2IYx43TIgvKPnUOnDvW+8bfc59qm
         h/+hGTj9RFKZX3oOtIfvr1fRD0JlxfgF3zIXpMOASHGA8e7JNS5cIVCsc+OAHoSDXbAp
         03cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700541969; x=1701146769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caEKODLYD8G56ZBu+Ji81b5D6XsHS3BHDDu1vj7HIIk=;
        b=bFxxNNYIK2rz82US8sH9Mky+iMmR2M2hKKdfetQa7xVRjhoWDhN8XIBrJ/EQnNv8O/
         OOrqD7KanAri6y1i1dB9znyT+xalbIvR9M9mj6f0Lda1a8hYdWhx1RyFIOEwx1zo6Gmj
         cr081OR+uc7GMlJgBVgH/zJK1MgZxx6HVs7c9QyETEpj/sh/F9GXpybP2QpFo4XCDoHT
         f7nG9Gmod449Yia5GzFc9/NJwxF0e1XrsTxD2hpY4CExWw3PLnRLw/DqnmdgHUisKaIM
         ksXWVeekwUxEXG947k9Q+5GtTzddKtA3LDWeYzUhXnd5RCbxzVGX58ZdXvkUy/6v/Uro
         55OA==
X-Gm-Message-State: AOJu0YyhTXesSLy5ddYRBebKrpsJUvSBBgQCr9CWREiRh2L0jj0MpXH5
        4lKObCn1xJxL6WbzO9LIdn/AVnfXDhaDT0cacAs=
X-Google-Smtp-Source: AGHT+IE8RnabTJxxdEhNU0aOmrkKMzryDkJQy163sLFdLj3j2itVGDLUp8RoRvYMJ/E3cYf9Lr2i6uguoD1OIvOodkY=
X-Received: by 2002:ac2:43a5:0:b0:501:c406:c296 with SMTP id
 t5-20020ac243a5000000b00501c406c296mr6562165lfl.31.1700541968641; Mon, 20 Nov
 2023 20:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20231106152428.3641883-1-sean.anderson@seco.com>
In-Reply-To: <20231106152428.3641883-1-sean.anderson@seco.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Tue, 21 Nov 2023 10:15:56 +0530
Message-ID: <CAKfKVtEqNn77K5JwOmc5B3+-fj0P0LtjcpUpN03hht7Pj75zYw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: uartlite: Document uartlite_data in
 kernel-doc style
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 8:55=E2=80=AFPM Sean Anderson <sean.anderson@seco.co=
m> wrote:
>
> Use @ and - to conform with kernel-doc style.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
