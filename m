Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62C80ABED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574586AbjLHSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574152AbjLHSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:19:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692590
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:19:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1cc518c5bbso65166766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059565; x=1702664365; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+e2GMm4IxE2ZPhAT3rwUK0y+pX6drbXEPnTu9WgFI0=;
        b=OJSod/sbEZ1pticSC/wOfUYgOFlSTK7TejD1Chxyydzbmu7QPen3IhkkOkzA+yRtlG
         OK1KVOCHuhkEgQSGZ+b/N4rq34B3ilZ99sHJRSJT8FNYUWhfzQegU+nTifRrl3jUn0oU
         S3g7OYydJpLC0fszdQtBTIbqxwjlpJPcXGeG74kWpRRuNm0GyNJWPwGZvzrs5WHLMsrn
         VfTG4DfdDiOY/19FNHOKsHOkcB974VR8bp9h5+4EmTNtUJjod+Vm7ezsUdyS6ExH6sEZ
         ODbstpQK3gw7cTL75zN5iWL9VkYiiUU4KqTZHWL/ss105curcYba0XbaQ8fExbdA9AG+
         FsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059565; x=1702664365;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+e2GMm4IxE2ZPhAT3rwUK0y+pX6drbXEPnTu9WgFI0=;
        b=p4PnirrgYcieAlbPDQLdjPHqVI+qj27a5Hv/1LiHLZFwvY8QxWI+B4fLRZsmJ/NtbP
         dm7DzL+hPExzTGoGbzGrhYmrQrTZm95t8Q6fGXhVEIBj1GRF1QoCv7gcQk7qMN1DaPcW
         dMt6LYebGPLGCvdCxmE8uDYSWUwweicqzOHwsBO5NYPogs0q7qu83JC56EYb25/n8qZv
         A6tOnDH0fqRSBH8a2LFnK0AxsrIBZ05rXKG8xcxuW54sen5JJeJ+efYrdR6IU9EkiPiv
         co4Vhkq0mR+WTHrIMSzaDkh84ajPOYOF1TuxkYbtS/qok6jv3VcvV8BR6pM21tk0jUZV
         JWJg==
X-Gm-Message-State: AOJu0YzGtVH07SeTXQJNbGJLC8dZoEDyfzZ6Ugt4lw2Ko818Z1j4MSWw
        mGM6Do2z/W902tFSzxLWGD0NChSh5W4=
X-Google-Smtp-Source: AGHT+IHSHhKdNhaPS3KTBL1ZnE1s7W/L7jwh/CBnt54AmVGKgSBxevLAmAfH0JXel/VQQsT5N6f3Lw==
X-Received: by 2002:a17:906:ba86:b0:9f2:3e76:5d39 with SMTP id cu6-20020a170906ba8600b009f23e765d39mr513767ejd.0.1702059565189;
        Fri, 08 Dec 2023 10:19:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090611d400b00a0d02cfa48bsm1277795eja.213.2023.12.08.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:19:24 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:19:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8192e: Remove c files dot11d.c/.h
Message-ID: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtllib_update_active_chan_map() as "active_channel_map"
and "channel_map" have the same content. Content of "channel_map" does
not change.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Used the following code for testing:
struct rt_dot11d_info *ph = priv->rtllib->dot11d_info;
for (i = 1; i <= 13; i++){
	printk("priv->rtllib->active_channel_map)  [%d] %d\n", i, priv->rtllib->active_channel_map[i]);
	printk("priv->rtllib->dot11d_info->chan_map[%d] %d\n", i, ph->channel_map[i]);
}
Log:
[ 1141.288386] priv->rtllib->active_channel_map)  [1] 1
[ 1141.288393] priv->rtllib->dot11d_info->chan_map[1] 1
[ 1141.288395] priv->rtllib->active_channel_map)  [2] 1
[ 1141.288396] priv->rtllib->dot11d_info->chan_map[2] 1
...
[ 1141.288426] priv->rtllib->active_channel_map)  [11] 1
[ 1141.288428] priv->rtllib->dot11d_info->chan_map[11] 1
[ 1141.288429] priv->rtllib->active_channel_map)  [12] 2
[ 1141.288431] priv->rtllib->dot11d_info->chan_map[12] 2
[ 1141.288433] priv->rtllib->active_channel_map)  [13] 2
[ 1141.288434] priv->rtllib->dot11d_info->chan_map[13] 2

Philipp Hortmann (5):
  staging: rtl8192e: Remove function rtllib_update_active_chan_map()
  staging: rtl8192e: Remove variable channel_map
  staging: rtl8192e: Remove variable dot11d_info
  staging: rtl8192e: Remove function dot11d_channel_map()
  staging: rtl8192e: Remove files dot11d.c and dot11d.h

 drivers/staging/rtl8192e/Makefile            |  1 -
 drivers/staging/rtl8192e/dot11d.c            | 29 -------------------
 drivers/staging/rtl8192e/dot11d.h            | 30 --------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 --
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 drivers/staging/rtl8192e/rtllib_rx.c         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    | 19 -------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  1 -
 9 files changed, 85 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/dot11d.c
 delete mode 100644 drivers/staging/rtl8192e/dot11d.h

-- 
2.43.0

