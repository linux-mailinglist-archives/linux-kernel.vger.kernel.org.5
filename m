Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA887B3EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjI3Hof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Hoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:44:34 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75025BF;
        Sat, 30 Sep 2023 00:44:32 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so5438954fac.0;
        Sat, 30 Sep 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696059872; x=1696664672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbxvayBBL1LZMvkAgSgbJrDuTM2+9jSeKuMGIK8uzTw=;
        b=YE0MezBrgeg/TBBDwk++sz33d7t7nQxkOhmB4I8/kaispVtYBQFAdPR6tkc+bRelqY
         WzKm6E1TuuzrioHk+UGZzw+LsnOL6+2GPxXpc21GmIsgvjqBqhp4yayThdMETpI3oqCl
         /Tvtu9sSO9jQgjMv4SXh8Q2FE+HoMpFhI0tAMelwDTy0/xnjH2C7sepS8hJOXk2tKFc4
         Nn9iski63nn/ZuNTwWMvsTh235TF5/0OCbqmqRcAnMCSsVGgdrkXdQmVXl+VoaRLbVd+
         s4gv7+++7AOYUy0NpdPVf93VjIwi6huzpL5D86n+ao8+o1Pq9YL9dJRsTu9hE4H0LUwo
         KJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696059872; x=1696664672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbxvayBBL1LZMvkAgSgbJrDuTM2+9jSeKuMGIK8uzTw=;
        b=JdRg6mwdVmysT/KiL6FUBS7LOUdYrIzBWPkw8MEouLS0TERBJaKmjnWE5xEK4l7HI1
         t8APPBB7oYmF8hpqeqMNYr46gotwM9BtcGSqj+z+cgRJ6oyXGgO9rHl0e0C5lxfqvejg
         RXVKOia9uVt18/4bv8Sk1q8/ZrGNODB1wXwT88MQuXmRCHb7maBpbULR0sk+ZbwI+vpv
         +oDcwUHcCecP/uYQYT6JbuXlJA+y6ajuqb0SRz2e48HtZzwr05nIPp5McHXQa4XlnZ7R
         /o2STQ3btl7+BYkXAtK9G7yVlTXXhdONb+XrNNMIvbctDb/rn9fRYN+/V0kdxZMzB1do
         PMag==
X-Gm-Message-State: AOJu0Yw9WD7+PwGXxwsSzaQTFv5zDGfuMW405BqVc/oPKnZym5Hy5yAZ
        Q/q3jlOrC/GEeaxhr8A7g4xwLpHVirao
X-Google-Smtp-Source: AGHT+IHwzjP/6135BmZyfJjutxvh7TCMU/FeNLkEdg2LRmmPsMyE/M+aS9lKoJZ+vD+8eEtH5mUlMQ==
X-Received: by 2002:a05:6870:2197:b0:1d5:adc0:4a1 with SMTP id l23-20020a056870219700b001d5adc004a1mr6980589oae.22.1696059871763;
        Sat, 30 Sep 2023 00:44:31 -0700 (PDT)
Received: from localhost.localdomain ([62.204.54.223])
        by smtp.googlemail.com with ESMTPSA id e20-20020aa78c54000000b0069337938bdcsm5561666pfd.125.2023.09.30.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 00:44:31 -0700 (PDT)
From:   Lu jicong <jiconglu58@gmail.com>
To:     jszhang@kernel.org
Cc:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lu jicong <jiconglu58@gmail.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured as host-only
Date:   Sat, 30 Sep 2023 15:43:34 +0800
Message-Id: <20230930074334.1406464-1-jiconglu58@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627162018.739-1-jszhang@kernel.org>
References: <20230627162018.739-1-jszhang@kernel.org>
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

It seems that this patch causes driver failed to initialize on rockchip rk3399 devices
when DWC3 controller is configured as dual role.

[    2.827119] dwc3 fe900000.usb: error -ETIMEDOUT: failed to initialize core
[    2.827881] dwc3: probe of fe900000.usb failed with error -110

After some tests I am preliminarily certain that this patch caused the failure.
