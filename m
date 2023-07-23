Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4707F75E4BB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGWUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGWUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:07:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAEAE5B;
        Sun, 23 Jul 2023 13:07:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b4749013so29570105ad.2;
        Sun, 23 Jul 2023 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690142822; x=1690747622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2O/oL2BEJ2VfQn4coTyhVQ/Czd2OJD9YBEHICa4/BqA=;
        b=MiWFMKL5bPiLbeh2ukKjKgjIn+PJFkPVbu437q2YnP+DOosmVji53AtZjekwjRMm48
         F6cGou2Wq0gCXhG2RBtDjBtVotftoiAMIRqyfmv0PqjQK9v54ymoon/LRfWZn+SVhSGj
         y7LZ9bZkpphbjRIpSrthAtz2UBVzZybSgGED5tmyFaX17eDy4+kD4uRRSW7Gn/0dRhy7
         014Hy50VDhYKA4soO2+OVElplpSNfejYag4zOnV69VCU61No0rgWdVWCj0CwYpG39keq
         nPYw7URgb7HnF3napxVbeIbjofWqfKhew7WhSH29s32fYNNhZtsIKVbLthZv+2BCk/3s
         EKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690142822; x=1690747622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O/oL2BEJ2VfQn4coTyhVQ/Czd2OJD9YBEHICa4/BqA=;
        b=GeYSs0M/QQLmRC1Wz09ABnv+Jg5ZHaoTxxZKwqeGyu6ACUJP6sb3xhLaqg/WiREFXn
         Ppt4gUSrwJQhASVNqXqet+xRDwXYMZicrgWvq2ptWYcNQXHiX7Lcxg1H/73DHp/YTgIe
         9yDRqEj2oT+beb0/CEwkEl+Mwud/JaCoPClK1QyZCY7Tl3VRw7yRrV0s2ytwQI4Gp7bf
         y8LLJqgIHGbpB8LNGrzwWcL80Vd+GrNma5p4GQsH3CJ+ahMq8yUbSiGjRxDY53S5XuqK
         1OMBisNzWBTbpjvtsb/QRbZweE8qDHkaYWfuhpRTQFX+gdO0SO5TNXDMwMUqQ50saXgX
         ToHg==
X-Gm-Message-State: ABy/qLZVtopJr5duqoseZ+2QsoUz0BJox6+rCqHW4hJWNMAIi0QgpdX4
        Uw010W/A5+Q7ZJOld213bQk=
X-Google-Smtp-Source: APBJJlFgVpcLCsu/vAetSPzqAjzsWOwiBL0k/NX4Js061IYVBIA7wFyDSzk35Wk5lxfPMgUxU7ZX/w==
X-Received: by 2002:a17:902:bb88:b0:1bb:97d0:c628 with SMTP id m8-20020a170902bb8800b001bb97d0c628mr2607854pls.31.1690142821587;
        Sun, 23 Jul 2023 13:07:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001b9cf522c0esm7241159pld.97.2023.07.23.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 13:07:01 -0700 (PDT)
Date:   Sun, 23 Jul 2023 13:06:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
Message-ID: <ZL2IYrswlWiUXUDW@google.com>
References: <66228ad3-c087-418c-925f-b9fd4a60fb16@sirena.org.uk>
 <ZLWIPPAfeR1+KbeH@google.com>
 <OS0PR01MB59225D8CF3E96808DD776A8E863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLbbslBiIQXFWpmN@google.com>
 <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <ZLsCOj1t4JvG3SEp@google.com>
 <TYCPR01MB5933D4252360AAE57D90FE1C863CA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <CAKdAkRT9tMnLnDLgWAevE_4HQ0wYMPehvsYaAeYrXdGGiyjXRA@mail.gmail.com>
 <OS0PR01MB59222E6CE0EEED3A5FE843C1863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922328753110C5C35101357863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922328753110C5C35101357863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 06:50:29AM +0000, Biju Das wrote:
> 
> Can you please post a patch based on this?

It looks like you are already taking care of this so I'll let you
finish.

Thanks.

-- 
Dmitry
