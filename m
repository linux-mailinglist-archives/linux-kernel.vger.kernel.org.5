Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D976E277
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjHCIHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjHCIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:07:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08B5FDC;
        Thu,  3 Aug 2023 00:58:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb775625e2so4866145ad.1;
        Thu, 03 Aug 2023 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691049522; x=1691654322;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26uR9UaiXXzwihC5bH3y0QcjO+NylXUnfJfeKoNSS1U=;
        b=PN9WJQB4qfquB7JcbPe46Sddf1U4zmsqWtTEQEdrPUq1J8JLwfDK0j8KuIZY+ylXI7
         /9JqTIUn63Yfiauzs9gaSRqZykC/byTihu9cy1KYNgpxAipF9N3vfin+5ceGzxPTRvul
         vl3L0+lEcWK3+IGCbMZT4jJ0Q4jQmmaVtz3NiMhY1hm8nas4bGKNuoWsnRSoaALmgZh3
         qaLGYTNwemfi9D4Ct6twVqhLkSSI/WwKo3dWj3Om0bRj4J0SSM067iVjs3NkiByJaBT6
         PoJM5ANWDhjmlLK0nhNnMU89/8scto/7lPKUhOd84sTEwOa3wxbhEQ3tCX7MuwSB+S4t
         QU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691049522; x=1691654322;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26uR9UaiXXzwihC5bH3y0QcjO+NylXUnfJfeKoNSS1U=;
        b=Rdm2tL5+7G4XuA1XiDaXFAG1bAun6Dtl0o8aVLGxzZnQ4anBqqUWHsChvHNHt3md1D
         6l25gv7JUdK+C8Noiv1+M3zANyeiMbkMbaGJaO3LAITItVcidGnL5sjNXrICJiauP6M5
         cHFBmk7K9CzWWv6ojwZBiXdzXHeEQFy292VpI69MTHTBtKVH1pfz9VsqwYgSQvPHN+hW
         9gE4tP1So7CEd342+gM/TQFr70NXx9zQ9MysJqJSf9afnO2AX//2oeVw2pr1Fy1aUsVh
         ZHRQcqcd9aGzFYJnqsHm435VZmN24piOO9pCXNjO7ZJ9pge9/upd5QJUHHFGYXvcCfqX
         PWaA==
X-Gm-Message-State: ABy/qLZrJa1wiuXnbq8gPnb/IhjZoUP2igncVl2QQ4ZD1sBk1cNsoNk/
        bj6eq7y5iOZiCqDch4hpprrC/Dt7nbK3Iw==
X-Google-Smtp-Source: APBJJlFJpRB6gvoyIuCHI0eI5TCfKtrpeiqsmVOJatGuG3eq7zs/BY48EDTcy7Rs0SVMA9ZaZkLc/g==
X-Received: by 2002:a17:903:230b:b0:1b8:656f:76e7 with SMTP id d11-20020a170903230b00b001b8656f76e7mr22600601plh.23.1691049521874;
        Thu, 03 Aug 2023 00:58:41 -0700 (PDT)
Received: from smtpclient.apple (g1-27-253-251-130.bmobile.ne.jp. [27.253.251.130])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001b9cea4e8a2sm13674877plj.293.2023.08.03.00.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 00:58:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
Date:   Thu, 3 Aug 2023 16:58:38 +0900
Message-Id: <D28BDDE3-7FE6-4ACC-98B9-B6AB6D9518A3@gmail.com>
References: <20230802184849.1019466-3-arnd@kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20230802184849.1019466-3-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 3, 2023, at 04:15, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> superhyway was only referenced on sh4-202, which is now gone, so remove it=
 all as well.
>=20
> I could find no trace of anything ever calling
> superhyway_register_driver(), not in the git history but also not on the w=
eb, so I assume this has never served any purpose on mainline kernels.

I don=E2=80=99t know, but I think it is fairly safe to assume that there wer=
e no superhyway implementations other than internal to SuperH Co (or Hitachi=
).  Probably not at ST either.

I think this board, and infrastructure, can go without affecting any actual (=
even historical) user.  If anyone wants further conformation that there are/=
were no users of this in the wild, raise a flag and I will find out.

J.=
