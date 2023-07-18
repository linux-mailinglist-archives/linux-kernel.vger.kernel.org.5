Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ABA7576F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGRIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:45:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6254FA;
        Tue, 18 Jul 2023 01:45:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3085305a12.2;
        Tue, 18 Jul 2023 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689669945; x=1692261945;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOBZtI7zq0pDtpmxxDapiR29tdvAo47dh+89oqAxAxQ=;
        b=V5IYMM/obyIyZDLEfNJ4gS5+PFG8QYImnOJmdsGv2seP2gnYvIZMKKFbx0pvFDmvrb
         nQPUZx4QQanAmaCvQ38Hza+zq10dqz/jIaObvsSFSwCnFcnHOXE5MoZL5mKCiusatjqQ
         tv0JblYQdbbFJCiTaC/R3qOyUblkgCJAXumm2uki+ecKkx33cyCVBsak/KJ4VUhfQ6wR
         RMZtWVj69KvaTEk7/wE6n8nD/MG4UAiTJAjPoUcTpXo/0YwxipnZ/ibXrxu3ly1ndd3O
         CA3Sqx0ti2AKtOvh5wWU/XniWusUVMBHFsYt/O71ifGrrk0LLEAsgrVoarA750ZVGhkh
         i22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669945; x=1692261945;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOBZtI7zq0pDtpmxxDapiR29tdvAo47dh+89oqAxAxQ=;
        b=HnNXWDfVZFJcFT9anASiaUlNZyr7+0HV6tM8Cy/HXHAnqe8gGlM4oqxS5/XLJfRgj/
         leeI20Faw76EfnBCqKPcTxE03whrdUybNiih3eqaN5J1qFYPcBPdmFshDHCIiMTewFzw
         z/Cxe/MO09iSjTm14zKIEhq8jPJy/iJMPPngMqQuDym9k+98h9/WyxuHBGfv61XxX/gs
         tazZ8jXDH64QwRgKVxdly4883s2rELjLRQjMGA9sFjrjj20Dhuzp8QJNXCRC32QTyBDw
         HeeOgIFJ40zyImr16s7zNG+0NoVAYGZbbEtyyBNPML8xf3W2TUC3F3yTMRc9tIZlPEAX
         Jueg==
X-Gm-Message-State: ABy/qLaogksCoSVBeY0F3wcFBboKg/ks+yTB2ZaLuSjZrzzq0fs3VcgR
        WLnhopC+kEp8kz+Bu0ewaWArpj+iP0NvgtLr
X-Google-Smtp-Source: APBJJlGHrx/jx4rz6Syig56z0O+zwfso+AI83xdK2D9AOf/V6WZTAKb+JoXX1naJ15Hh6roXqD7y5A==
X-Received: by 2002:a17:902:7201:b0:1b3:d4ae:7e21 with SMTP id ba1-20020a170902720100b001b3d4ae7e21mr11523786plb.63.1689669945333;
        Tue, 18 Jul 2023 01:45:45 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001b9fef7f454sm1291516plb.73.2023.07.18.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:45:45 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        YHYANG2@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH 0/1] RTC: nuvoton: Modify the setting timing of write ownership
Date:   Tue, 18 Jul 2023 16:45:34 +0800
Message-Id: <20230718084535.11081-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the write ownership to default.
- Set the TWO bit to gain write ownership for BMC before it updates time.
- Restore the TWO bit after BMC updates the time.
- Set 24-Hour Format.

Mia Lin (1):
  RTC: nuvoton: Modify the setting timing of write ownership

 drivers/rtc/rtc-nct3018y.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.17.1

