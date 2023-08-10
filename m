Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9CC777482
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjHJJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjHJJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:31:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE710C4;
        Thu, 10 Aug 2023 02:31:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f8614ce5so597507b3a.3;
        Thu, 10 Aug 2023 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691659913; x=1692264713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuYnKqZlhXtvL5IlwCDflQwZJ/nXNZUmhTLvqurACQQ=;
        b=Haf2H68hz/zp+F2we2FhxSEMG5/FkA9VdEiCeskbKrsTjaaONF+p97MRh2sskG4HUd
         LJBkYiTFq1Uc7xuiRGyewc6p3cXer+j4KSiCxGfgBdPcBty+o7xCgL/dJHMVLlZdJaJ/
         2aWFCV7lneImvwJds6FuQg8CB2nrHAEWommpZ7gXFiTVTtqD1AZLQ053a43Ri7YJBpwn
         A5YTHYRZY2L8hk+8YMMk9baw4S0/6lKaks+CmIhZQ/9Y4KfB/7td4eKJFselDVJnqsKH
         F0/mPb58+ujRgCNJjwGr2g8AY1HGV/A/mGbdic2AKclZjJpj5+O4ddUgyeSAX/DArtac
         mksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659913; x=1692264713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuYnKqZlhXtvL5IlwCDflQwZJ/nXNZUmhTLvqurACQQ=;
        b=kOsab/0wzW8Q12Fcd+F2X/qXE41923iUv51D/6KWdZjC5xcA+nff2QTB7ESr0CL9J3
         vEVWvf3t1snvD0ga1pHvfcdTmLzUlj/aBEbA0a9FGbihv47ysl0yiPsjlb1XWs70JLFW
         rDj3hPzjn17XkC7xt9uewKxWBotnhDbFCt/7c+8oxj7BAzTJrTkrNw/QZlMprEKGSqw5
         P0MXP0ZlggkLuI3gH0fr/Y4yJ4hUACA3aw9eRB5jyYBnhXeQjoQ8fVZ5qv6dBfVzsBgQ
         rNDMJUSozBm1vuDmu/P2s9euZcZbkHyzCF6UpK25kbxzzIPbzezgB4bAEHcToVUNfna3
         yjVg==
X-Gm-Message-State: AOJu0YxLpzYHt5U+6mh33RFSDMZ6DMFXwkrdLPjyCJaXDBYgbOgQrLP2
        Ju+Vz+E4c/VYOlyAPdAfRGU=
X-Google-Smtp-Source: AGHT+IHHib6JabmDBlPkzeuVdYjC66lZP7dwSGkK448fpkokNirsESfH14bYa2Rwt389XdgdhYZBNg==
X-Received: by 2002:a05:6a00:14c8:b0:687:5c3f:d834 with SMTP id w8-20020a056a0014c800b006875c3fd834mr2675040pfu.11.1691659913104;
        Thu, 10 Aug 2023 02:31:53 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b00565009a97f0sm1064352pgd.17.2023.08.10.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:31:52 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Szuying Chen <Chloe_Chen@asmedia.com.tw>
Subject: [PATCH] ahci: libahci: clear pending interrupt status
Date:   Thu, 10 Aug 2023 17:31:47 +0800
Message-Id: <20230810093147.45678-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 14:12, Damien Le Moal wrote: 
>    On 8/10/23 14:05, Szuying Chen wrote:
>    > When ISR handle interface fatal error with error recovery after clear PxIS
>    > and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
>    > during error recovery, which causing the HBA not issue any new commands
>    > after cmd.ST set 1.
>
>    This is not very clear. If there was a fatal error, the drive should be in
>    error state and no other SDB FIS can be received as the drive does absolutely
>    nothing while in error state (it only waits for a read log 10h command to be>
>    issued to get it out of error state). So if you are seeing 2 SDB FIS with
>    errors one after the other, you have a buggy device...
>
>    However, I may be misunderstanding your issue here. Could you provide more
>    details and a dmesg output example of the issue ?

According to AHCI 1.3.1 specification ch6.1.9, when an R_ERR is received
on an H2D Data FIS in normal operation, the HBA sets PxIS.IFS to 1
(fatal error) and halts operation. Referring to SATA 3.0 specification we
know the device will halt queued command processing and transmit SDB FIS to
host with ERR bit in Status field set to one(set PxIS.TFES to 1).

In our case, the ISR handles fatal errors(PxIS.IFS) and enters error 
recovery after cleaning up PxIS and PxIE. Then a SDB FIS is received 
with interrupt bit(PxIS.TFES) set to 1. According to AHCI 1.3.1 
specification ch6.2.2, HBA can't issue(cmd.ST set to 1) any new commands
under PxIS.TFES alive during error recovery.

>    >
>    > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>    > ---
>    >  drivers/ata/libahci.c | 12 ++++++++++++
>    >  1 file changed, 12 insertions(+)
>    >
>    > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>    > index 06aec35f88f2..0ae51fd95d46 100644
>    > --- a/drivers/ata/libahci.c
>    > +++ b/drivers/ata/libahci.c
>    > @@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
>    >
>    >  void ahci_start_engine(struct ata_port *ap)
>    >  {
>    > +     struct ahci_host_priv *hpriv = ap->host->private_data;
>    >       void __iomem *port_mmio = ahci_port_base(ap);
>    >       u32 tmp;
>    >
>    > +     /* clear SError */
>    > +     tmp = readl(port_mmio + PORT_SCR_ERR);
>    > +     writel(tmp, port_mmio + PORT_SCR_ERR);
>    > +
>    > +     /* clear port IRQ */
>    > +     tmp = readl(port_mmio + PORT_IRQ_STAT);
>    > +     if (tmp)
>    > +             writel(tmp, port_mmio + PORT_IRQ_STAT);
>    > +
>    > +     writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
>    > +
>    >       /* start DMA */
>    >       tmp = readl(port_mmio + PORT_CMD);
>    >       tmp |= PORT_CMD_START;
>    > --
>    > 2.39.2
>   >
>
>   -- 
>   Damien Le Moal
>    Western Digital Research
>
Thanks. 

