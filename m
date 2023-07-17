Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA397563A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGQM67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGQM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0E210A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:58:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1181690b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598682; x=1692190682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxuqeyRLaGsgNS7cAk/VqAg+8wOCZMSgEI8rvm938k4=;
        b=C4sMqbtnpXDlshts60r/+0Ez4QLa3NwxAmYEzemv8uCYxfBgYZkk3It9ABO4G4/HZL
         ZqJTnfu5Tj/VntYxD43FFdUgweGRwV82HJwLKJGCN7oHVvWpDYNF3CSkp3OJ3iO4MxoM
         9u9kod6Pc2YAEZmirmWjjP5Pe3WupvJHsRS6/JUYtA1c4RBlgF/GTGq2YSIW4VQObMF/
         iaKu7cO7YGhaU2Jf2YNViewo/iR+0/RKxGj6BrHrAYyFKS+qoX9oluTXCVY1hNq4aw/h
         JH2OjUjktf3FTNrICRRUQhscQvDRfnf9S0ro9mh8daFPCLJ5ODEGnTgd8Wxg3cRjxOGj
         kJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598682; x=1692190682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxuqeyRLaGsgNS7cAk/VqAg+8wOCZMSgEI8rvm938k4=;
        b=jltpQBXEyCvstjZweSVhCpP/h1b5FtgLqin6uLoiGgQ3tWyq1gj8xrmmqHJm28/ZED
         9/HdvBvFhi71DIZO7AKNuvbYlhuxe/DkSE56hEG/TjHlKFhhFSJk1APF3b/zLkwK7ru1
         Ghiqc1nHHA5DwDyXg0Ham5tlJT+VY29yMalFrqlJHJJ5gwsQUkHMQz2/lX7nFHg+Mf3z
         vLcN+Has+mQlQTCoAYG9tWi1hBwSv/nbV2gXS8JVG8y0pXJqRlBWqLcSuvze+Eeu5V31
         99SzerTAEwx2uTLA4Itncg4yen/da03S/2cMCEuDl89ec5gBc1bPp6Lz4E0EQbapr30+
         vURg==
X-Gm-Message-State: ABy/qLbCsyMOKmlknf8d2JiP/SOLB0F0YW4lQLovaqNCe0HA8lS/lHRr
        REjkQtOZdF7lJ/TUa40f2ut7o5tBSUQ513BF1ncKc/SLZY0=
X-Google-Smtp-Source: APBJJlE+HoutIK0nYRGucBoutTN8r7cbUC50Qgs0XXpYoXMdjkD2MMidht1fWvrtSMB3N9kLad/8McQYvSeOZVpSZLI=
X-Received: by 2002:a05:6a21:998b:b0:133:6e3d:68cd with SMTP id
 ve11-20020a056a21998b00b001336e3d68cdmr9189787pzb.3.1689598681751; Mon, 17
 Jul 2023 05:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230712124934.32232-1-matuszpd@gmail.com> <CAOMZO5ATTK7UsTRPTF_7r86WbNmAhtpEphO2u896QqARTk2kpA@mail.gmail.com>
 <d2cbf249-32e1-4e19-8362-7087d6b7d3d8@sirena.org.uk>
In-Reply-To: <d2cbf249-32e1-4e19-8362-7087d6b7d3d8@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Jul 2023 09:57:50 -0300
Message-ID: <CAOMZO5A6YrUX58VwZtbzOV6UBsvE+AF3U5i8_Vr2E_VOb49zKw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Disable bit clock with transmitter
To:     Mark Brown <broonie@kernel.org>
Cc:     Matus Gajdos <matuszpd@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 9:55=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:

> I'll just put a non-specific Cc stable tag on it, that should be enough
> to get it backported.

Sounds good. Thanks, Mark.
