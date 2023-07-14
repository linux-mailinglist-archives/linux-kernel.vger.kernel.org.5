Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF5753F91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjGNQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGNQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:11:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905F830F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:11:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-991c786369cso270631866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689351075; x=1691943075;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekE4GFRpSzxYfGk8fJuTtkDmPZ364k3ax4tchzxCEpY=;
        b=CZwRkDoqV81MTc26Fj0vcPlbSj9UItvhxsFuVQ56Qr7Of3lIqmRz7Cne8RjYNp5MzB
         e1TTWEvUOzGERSgLv921jX65xEIurqaZP40/2FvaHFFzc3amVx2YbUrvX8z1gu4VaPJV
         SCovw4bEedPCFRQUHdDzo4yj/kH8d6ZoXnlfal/3wNTsS6DBpJFFcPGpMRMbVr8ZoY+i
         s75Pf4QXUUWbiBmp3+VPUi15khWeMvPzJoiKn0irEi/awkmTJzSlEEZnBq9ZojKI+sSK
         yQvkVRtWNEto7CSYarTFzrBewnzcliUn2L8PwCemMMx4UOSFcuQzanDwsKTKTIncCHtZ
         W5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351075; x=1691943075;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekE4GFRpSzxYfGk8fJuTtkDmPZ364k3ax4tchzxCEpY=;
        b=L8kgAakC/xpEdXfHBQhUaJNS26JM12xDCgbqud+16IvS+1FLMCWFsEKu/DCeuOOs5J
         FGApdwSwJ6TV3WvLQjhG1OwyfcHS8sym+DnfiGsk9GmxM7T3wychhuHgQWGH4g3uklm0
         icM6A5w0+kqFctMmBFePobdm73xZZqfNVFblc1y9q1P1WFyxucUVCCGUBxGEZBGMCKXu
         6Yew4y/XtRf2oWP4PfHOmDZ/anltZZ74LS3WOpHG2C1iZphmKR2VwgMUMvLk3Skcm9Wz
         L4ej92wFuE775URk9SZ9ZwqHRkYjyqOhtVlJqexFmbkhBNDfGGhudKN6u0uMdnG522bY
         g/RQ==
X-Gm-Message-State: ABy/qLY7g2mwwVIXs5arx5Gewp4/cX/Qbyz4/oMYOck1VR9+7oCfZ9Xg
        eWcoBbLvyWM20MjvBdwKj47rJuFUXROgQ8rA0Ug=
X-Google-Smtp-Source: APBJJlH1fw0ABebrraAXlbQXmult22lg0G6B/JnNICX9+m/lq7GvEGBQ6TqMJH7ikBsa70htIBWTg/3n3dtQ4pedbF4=
X-Received: by 2002:a17:906:d965:b0:992:b020:ce4 with SMTP id
 rp5-20020a170906d96500b00992b0200ce4mr4101906ejb.51.1689351074845; Fri, 14
 Jul 2023 09:11:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:3f1a:b0:978:7382:f684 with HTTP; Fri, 14 Jul 2023
 09:11:13 -0700 (PDT)
Reply-To: delucabarbozab@gmail.com
From:   Sergeant DE LUCA BARBOZA <kaborehilaire83@gmail.com>
Date:   Fri, 14 Jul 2023 18:11:13 +0200
Message-ID: <CAKj88B2EQZgcCEck-u+H18JfHpsdkLacH6YwFkvDyzzeRmfAkw@mail.gmail.com>
Subject: =?UTF-8?B?SGVsbG8g4p2k77iP4p2k77iP4p2k77iP?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Hello dear,
My Name is Sergeant DE LUCA BARBOZA. I am a USA soldier working as a
United Nations peacekeeping troop in Damascus Syria. How are doing?
Hope you are fine.You can write me back directly to my
email.delucabarbozab@gmail.com.. Hope to hear from you soon. Have a nice time...
