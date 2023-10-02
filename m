Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0747B59A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjJBR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjJBR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:58:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71DDA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:58:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-279013f9875so28660a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happybizdata-com.20230601.gappssmtp.com; s=20230601; t=1696269526; x=1696874326; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=HbUzHZWKilX0D/60gIOZxxJEoFaLfrX2GW6B4u996Q+PCgymab2fDqHCfyxW39rZbD
         j2ykBHnlXNe6eC3LxHYdsumI/gLRqdOu1m4beuM33KEdT+tCBu+hljDV/8mlVgaxBmia
         Mj0XsTSctZDLyB6TwO94Kd+H/RTHCP5Ok3A/zBnoSIIO8x5bG7H2C2KKE98pM3xDKbE0
         1H0a2Uzg81xhtdXX1poYasKxR+EqzyW6OHj+GNiA84kMow//590J/BmsSm9GiNDDBcmI
         2r2R45mimlqOfAC2HJHx02VAEwH2IzURuX146ic7k2ZYfWBqs4+8hranBB+G43BZagMT
         dm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269526; x=1696874326;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx3rGq7xkfpJfugVxIhCG8q+j0sp54c0pLA6F3q0y6Y=;
        b=eDuYXGUeXEeUe98sh9VUclJWYztVIzEOISkUei5np1l0lSx9fY964I6SRro5sBFfw9
         K3X6tQDjAalzRDC+C+hPmu4aBLMfK/6MFhZ5jxaLqMX12bz91Wuix2HTvoLZSiD+ZAtE
         oDnk5PCTp0CS/TFk7Ck8TuIdPxy1TIdr2SOl4Z/M69oSKBds45dLZtHx6TgcJmSlGOl6
         pmpWRYfnq6d9UL5qcAjWhNXBzfnsmQPreNJxdusKzIg0KnjAJ2lk+nZ0MRVD7cWt20r+
         gHLdAIT81bRtujDgYzwvTZKbYuz5Ve04uB9X48Cukup0D2qT/Fe0eHDYQNq/gb5cWwGP
         5kpg==
X-Gm-Message-State: AOJu0Yz9ZyjxW/w21//A+2f7bFAIryqCMMPhjThpgqx/M2eW1UaaoZWm
        jvDggIjaZS/QXdrNvjLSjK6r8WWouOZ1W4wiIwzeKg==
X-Google-Smtp-Source: AGHT+IE/Laa7rLx2V594Ztsf6S+kH7UMPiw7qk2OQu47pnit9fNeS16w6+MRe0gQQcYoWY2gBXGHDUy5vXGR7pHloMA=
X-Received: by 2002:a17:90a:3dc5:b0:274:c284:c83c with SMTP id
 i63-20020a17090a3dc500b00274c284c83cmr9756264pjc.48.1696269526133; Mon, 02
 Oct 2023 10:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
In-Reply-To: <CAMh3ZMJ_yEt0YCimcbJ+BwwJSX+PGktO6dGS1gmSQ1snAUqVpg@mail.gmail.com>
From:   Sofia Gonzales <sofia@happybizdata.com>
Date:   Mon, 2 Oct 2023 12:58:34 -0500
Message-ID: <CAMh3ZMJhP9rjxpdYwOiBRfg+0x40EutyKKhst9CWvKC2voHLtA@mail.gmail.com>
Subject: Re: HIMSS Global Health Conference Email List 2023
To:     Sofia Gonzales <sofia@happybizdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How you=E2=80=99re doing today? Did you have the chance to review my previo=
us
email with the follow up below request, I am wondering if it actually
reached you.

Kindly let me know your interest on this

Thanks and waiting for your response.

Kind Regards,
Sofia Gonzales
Marketing Coordinator

On Mon, 25 Sept 2023 at 10:14, Sofia Gonzales <sofia@happybizdata.com> wrot=
e:
>
> Hi,
>
> Would you be interested in acquiring the Healthcare Information and
> Management Systems Society Email List?
>
> Number of Contacts: 45,486
> Cost: $1,918
>
> Interested? Email me back; I would love to provide more information on th=
e list.
>
> Kind Regards,
> Sofia Gonzales
> Marketing Coordinator
