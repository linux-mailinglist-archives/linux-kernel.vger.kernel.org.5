Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113AA76E3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjHCI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjHCI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:57:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44818E53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:57:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso1242689e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691053051; x=1691657851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RYOvA3GPH9yLj5LX7ItcBXbKrc7dBhaTvMPDzCiKhI=;
        b=QYpmTq0iHjjpPUROzsfV3ui565+LyzJjb6AZIaR2NMmJq0sK3A48bcGty+dpOSeQa7
         QuHD1f9cYyP2WHWcPPqS2++NzTUR8+8GnpGP1+ZKQWGoGcN+Tk5wMMkGkjn7Huh3SFOg
         y2tUPyRRLAFSgKYkozMVDoA1YwvqO4/Rgo+vBSBqOsk0Gqro9NCEdM/YD5hJKzzA6sJO
         VdB0cClAJ42T0ojRpkkIZkCqtULtf31Swzq+nEl9AXh2HXWRV2lz9UeXvj/Ok5Yc6bkh
         Tphq9d9B1VPf6st5E/VRCbTvFD/BrlY0fzCb6N9umIxeU+4tGCT9uJ1SYySpM+E0OnnJ
         dOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053051; x=1691657851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RYOvA3GPH9yLj5LX7ItcBXbKrc7dBhaTvMPDzCiKhI=;
        b=fctYJ1PQTS/rb+hTcCF/aq8gJG3bqkFGQLPnt2TowF0XgXOLsjfypsn/VwD/NGqijV
         4ictkI5dpj595Rh/eTjejWtkO+ZQRvt19hySTfUaj+Lulbk5n6Q+/PVQ0CwPerEG+W6d
         BSP2eXkWNDA+DXTFyO2Msdc8WjaUsjt5RyZ8C9dld4Drz0Ndgp/GcnYOx1PihLcQKoAT
         6dnNiCY/xx/n6vU9B5J+Bg+HA17nHpPYycGRAVsNOhArPX1ZZFcAhAZ0yA/ECRCUz6Lt
         bp+/bQaHV4XbMXj4PiVDRm3tCh8onnSyxaAhjp7TkFc/2hF9GbgNnv/o0InALa7c82Gs
         jD/Q==
X-Gm-Message-State: ABy/qLak7/qS23Jii6x00+wbi7ij4Yt+sOnRpF1H1AhSt3HzT+qTbiW3
        hpBLWyTqmO8VeEPONxRwrOUeXQ==
X-Google-Smtp-Source: APBJJlFwAN56ckCsXu8+/F68+HPgxrLICVNWd/AJ12TY+DAcRjD+iVX2dddTKPWUYyPXdUiJsX6MXg==
X-Received: by 2002:a2e:a0cf:0:b0:2b6:cb55:72bc with SMTP id f15-20020a2ea0cf000000b002b6cb5572bcmr7115600ljm.1.1691053051344;
        Thu, 03 Aug 2023 01:57:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6184000000b003142c85fbcdsm21178152wru.11.2023.08.03.01.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:57:30 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:57:29 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     justinlai0215 <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Message-ID: <ZMtr+WbURFaynK15@nanopsycho>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803082513.6523-1-justinlai0215@realtek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
>This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
>applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
>
>Signed-off-by: justinlai0215 <justinlai0215@realtek.com>

[...]


>+
>+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd, unsigned long arg)

There are *MANY* thing wrong in this patch spotted just during 5 minutes
skimming over the code, but this definitelly tops all of them.
I didn't see so obvious kernel bypass attempt for a long time. Ugh, you
can't be serious :/

I suggest to you take couple of rounds of consulting the patch with
some skilled upstream developer internaly before you make another
submission in order not not to waste time of reviewers.


>+{
>+	long rc = 0;
>+	struct rtase_swc_cmd_t sw_cmd;
>+
>+	(void)p_file;
>+
>+	if (rtase_swc_device.init_flag == 1u) {
>+		rc = -ENXIO;
>+		goto out;
>+	}
>+
>+	rc = (s64)(copy_from_user(&sw_cmd, (void *)arg, sizeof(struct rtase_swc_cmd_t)));
>+
>+	if (rc != 0) {
>+		SWC_DRIVER_INFO("rtase_swc copy_from_user failed.");
>+	} else {
>+		switch (cmd) {
>+		case SWC_CMD_REG_GET:
>+			rtase_swc_reg_get(&sw_cmd);
>+			rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>+						sizeof(struct rtase_swc_cmd_t)));
>+			break;
>+
>+		case SWC_CMD_REG_SET:
>+			rtase_swc_reg_set(&sw_cmd);
>+			rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>+						sizeof(struct rtase_swc_cmd_t)));
>+			break;
>+
>+		default:
>+			rc = -ENOTTY;
>+			break;
>+		}
>+	}
>+
>+out:
>+	return rc;
>+}

[...]
