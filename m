Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0338E793732
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjIFIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIFIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:33:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A610CF0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:33:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2803531b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucd-ac-ma.20230601.gappssmtp.com; s=20230601; t=1693989218; x=1694594018; darn=vger.kernel.org;
        h=content-description:content-transfer-encoding:reply-to:date:to
         :subject:mime-version:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS7MyFNMCqPW4Okb8n9mOu6UP8Qfq0r1rfpQBYDXbnE=;
        b=PiGvQ9djdR7mzBWbgKcpzAFCGw2Cll7I9E7h7I5eBiQkKc1xadwlgNwQDZppX/Mgl5
         og5GWrXNRLt9HXVqMV3I/asmm3icWXwVYQpMpfMuu1feZrCefQ89ohC+Ckjvo3oyEw8z
         gBVwfxqHAoYiY5g29vyR0i+iW1Hs8X0eVxE4tYKYqhpVuFBd70a1PRqNRNDrSvFcaNsi
         HWHR7Oy/mkeCzfmWNS+30AmSC9YEVEsZJkDUqcHsQZpsPO6D/9YW0yoL+TM1xPqXavMb
         GzLZWHm5WyivyPcxYQMk1SsVjN6yvtLG+JnyrDmqjmTMT0Ki9Pi325etuRONcJC0SF2P
         ix4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989218; x=1694594018;
        h=content-description:content-transfer-encoding:reply-to:date:to
         :subject:mime-version:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS7MyFNMCqPW4Okb8n9mOu6UP8Qfq0r1rfpQBYDXbnE=;
        b=M0vCRKRfHK7GVBuXWtXDQF7v4vohEa+M7EWoSkU7h4/R0vn1/OjQIoOP6CHry66ruT
         iv74fsAZYWktd05lDHmw22xXR8DBtkIDrf40euRahfneOEkYwjG/M/nBjcRjJm19p1GW
         E2qxZLASv2AYor1mUsO21jeId7q4xf+wbhZw/I3EmFtblM8lM2+s0yvYFhrfLdZHnI0T
         jOumpO2U+gWw4gaYrXzkVGaUYJ6i6YoO6LX2wdiHM+31v/0zQibSwXkziHvarKiYUwFB
         0a//x/YsGJHKe7KTjfQZiJ1PwAT3gNd7sfmpqF9oJWokMM/LzTpPSYl+EwvA9kwiyLbU
         TsTg==
X-Gm-Message-State: AOJu0Yyeh2OXWxxQYKtCTWi2NO16erzS1IpAxj8t+elg1WY97N2qAOAJ
        RwUmciU/rPADBmVyAdke9mY/TCCwVb18PG6H9oLmd9DXOZmfFDQwphkkW7OvIBPZhG0akNHxBAm
        2BrKthKz04ZX5k5Hq
X-Google-Smtp-Source: AGHT+IGVnNxY5J06/xcAsDsD2nEAQ49XgTPRJFTcT7TfMla7Jm5efGRGNpK0+4KGj8de87Cj2Y498Q==
X-Received: by 2002:a05:6a00:2e24:b0:68b:a137:372b with SMTP id fc36-20020a056a002e2400b0068ba137372bmr18464832pfb.19.1693989217809;
        Wed, 06 Sep 2023 01:33:37 -0700 (PDT)
Received: from [192.168.1.7] ([86.107.104.243])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b0068620bee456sm10331782pfo.209.2023.09.06.01.33.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 06 Sep 2023 01:33:37 -0700 (PDT)
Message-ID: <64f83961.a70a0220.307c2.5fd6@mx.google.com>
From:   Li Yong <passerelle.esefj@ucd.ac.ma>
X-Google-Original-From: "Li Yong" <liyong@cnooc.com>
MIME-Version: 1.0
Subject: This is for you!
To:     Recipients <liyong@cnooc.com>
Date:   Wed, 06 Sep 2023 15:33:26 +0700
Reply-To: liiyong2200@gmail.com
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day!

I need an individual or company to invest with. Please, advise on investmen=
t opportunities in your country.

Reply for more information.

Best Regards,
Li Yong
Vice Chairman Board of Directors
China National Offshore Oil Corporation (CNOOC)

--=20





















**Avertissement (ins=E9r=E9 automatiquement) :**



**Ce
message et toute pi=E8ce jointe =E9ventuelle contiennent des informations=
=20
priv=E9es
et confidentielles destin=E9es exclusivement au(x) destinataire(s)=20
d=E9sign=E9(s)
ci-dessus. Si vous n'=EAtes pas le destinataire pr=E9vu ou une=20
personne autoris=E9e =E0
recevoir ce message, veuillez noter que toute=20
divulgation, distribution ou
reproduction de cette communication est=20
strictement interdite. Si vous avez
re=E7u ce message par erreur, nous vous=20
prions de contacter l'exp=E9diteur par
t=E9l=E9phone ou de lui retourner ce=20
message, puis de le supprimer imm=E9diatement de
votre syst=E8me. =C9tant donn=E9=20
que l'int=E9grit=E9 des messages sur Internet ne peut
=EAtre garantie,=20
l'Universit=E9 Chouaib Doukkali d=E9cline toute responsabilit=E9 en
cas de=20
modification ou de falsification de ce message. De plus, si vous recevez
d'autres messages sans cet avertissement, il est fort probable qu'ils aient=
=20
=E9t=E9
alt=E9r=E9s par des syst=E8mes externes ou des individus.*



**This message=20
and any possible
attachments contain private and confidential information=20
intended solely for
the above-mentioned recipient(s). **If
you are not the=20
intended recipient or an authorized person to receive this
message, please=20
note that any disclosure, distribution, or reproduction of this
communication is strictly prohibited. If you have received this message in
error, we kindly request you to contact the sender by phone or return this
message to them, and immediately delete it from your system. Given that the
integrity of messages over the Internet cannot be guaranteed, Chouaib=20
Doukkali
University disclaims all liability in the event of any=20
modification or
falsification of this message. Furthermore, if you receive=20
other messages
without this warning, it is highly likely that they have=20
been altered by
external systems or individuals.***





