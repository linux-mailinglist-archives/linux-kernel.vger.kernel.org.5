Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEC7C74DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379577AbjJLRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347412AbjJLRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:35:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8317296;
        Thu, 12 Oct 2023 10:27:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1057601b3a.1;
        Thu, 12 Oct 2023 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131665; x=1697736465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zlm6CWZnKCPJZluYdlrpPXBZjpw376jC++TlGrL7m2k=;
        b=mjWrJ0155sQdQ1QAaGFZV4sshO/rCZwy2+mlCD6tP99TYEpQ2z915yAmbt6YfrLIb5
         lCjCzuSd2/cDb2Ck1UIqLG8cTHPBACbJaAFXGuDXeA5wXOx2ct0fzicitiNTSJFrmb3J
         32Yst58llv7v5OE1baLBb7O95y5Y4KucmwFWOf/mMkBYE/2vsbNfgJR72mQH7hnYBPz8
         UjvYpF6/aRlrp+/yzbTDH9YinM9+hAk4CG5uXGnT+fmgwqEqwGbKM1Z/ZxQRhaTp2iUm
         ziIuWGvBqufBQKgimzkxZ38nI+t0FtSvPHb234o3U0ikZee9cAJ7vGsy/oXKIiSPbbdh
         gjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131665; x=1697736465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlm6CWZnKCPJZluYdlrpPXBZjpw376jC++TlGrL7m2k=;
        b=GHFcUqJgB54H2fdO5p/XNld5BRJ40anNetoDK7YdmMc1qk5nz88rhhwf8BTOxkhXbJ
         +eHwguso8gREg3ddlp+61RE7NQsjtZj13M2IkPfkoVRK71HoQgvdnFJFFUcTUijO/TXP
         5WawNpmOFjI3dmnHERu/VMuv8Kg557GEEprwoX8s+zwX3Xs8QpyvGjP6P/69B/qlFgwh
         AEobETG/R1VP/5rrAisb67N6RUi+hnF30hkzxxy+p73SHwjxTPqIWqkPD6WMTFx05O3Y
         Qt3jtkinmN3XyWq/tckA44gK1u7SKUZCbMuRM/I6Az31ndNRPXSRoHR5bnb72W46nGA6
         iPvA==
X-Gm-Message-State: AOJu0Yz1ZBG6vc/TRXHxbWUIT1BPuvCoLI7IErLCuvJErAJE224i+Lx6
        8gw1XgPOUKUSY/cTcvp9F9g=
X-Google-Smtp-Source: AGHT+IEnbEOfVXKC9Cu/Tpca62s3+j2t0CAyikXor5NWM/nqk+WTK/YeS0qoJoB1TfHlFKHXd7npsg==
X-Received: by 2002:a05:6a00:13a3:b0:693:4552:cd6a with SMTP id t35-20020a056a0013a300b006934552cd6amr26381008pfg.16.1697131664854;
        Thu, 12 Oct 2023 10:27:44 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u23-20020a62ed17000000b006884844dfcdsm11962264pfh.55.2023.10.12.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:27:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 07:27:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     WangJinchao <wangjinchao@xfusion.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH] workqueue: doc: Fix function and sysfs path errors
Message-ID: <ZSgsj7gb5786KAUa@slm.duckdns.org>
References: <202310121517+0800-wangjinchao@xfusion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310121517+0800-wangjinchao@xfusion.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:17:38PM +0800, WangJinchao wrote:
> alloc_ordered_queue -> alloc_ordered_workqueue
> /sys/devices/virtual/WQ_NAME/
>     -> /sys/devices/virtual/workqueue/WQ_NAME/
> 
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun
