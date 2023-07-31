Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A590769063
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGaIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjGaIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:38:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A157127;
        Mon, 31 Jul 2023 01:36:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56334abe325so2577254a12.3;
        Mon, 31 Jul 2023 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690792582; x=1691397382;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owacnea28Wr6aUajhRJnVxc/W4udlgY2n0jPX2C0X8M=;
        b=N/LS5c/i6/uBh+TLEKjX7CifFFqC+zvSvcphm0/QHJi/p/qGRY5gjAnRq9RycBt+AS
         j8V/uFYuq0RZnc9VzJg69hcycSsekxeea/UogD+2uEcdX5RSJeYkVa/7CMjPpUnah52e
         QHOtosT3wsf/huRMkPKT/vSYtjaV4y+z2Dq650Brf40jpohIDSl3YvV1Kydoh4/qleoi
         1xhABhQQgUiNEfqQFLw8DyFVnDDtfDWw1rFi8UWr4AiuYlPcq2I2bq+42saX2chGFb51
         7IVs/DPzLSAyD0rDqKM4WyWIixeIqIVOpMkjtsGGI2wC4ikvZpbrc/dAQXhBshvz9hL3
         p2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792582; x=1691397382;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owacnea28Wr6aUajhRJnVxc/W4udlgY2n0jPX2C0X8M=;
        b=LxH8sis0NcCK+LzYahyMlgGvItkQhxxTr3/VI1NhRSY/jFCqAun4yblZ5+bEilh06R
         6aYJ3QUBb07qUhCUlivxp5un5rOL1nUlfqBijI+VEqyuK17yJd62x91VTZrPf5UaUXy3
         yYQcJzhfa31gt/xV3/+/NKIQqmh+Mc64EQATwoPt3K0eE6r0yo9lYxJSiA4fzE24cdGa
         0SRe3dAZBmYUapqhmCT8armHJSP0SkzifpOjtmmlvwiv8FfAY09XYWrpjiwG8k4ZmLBO
         cxbFY6dvlA7c5dXqF25sIKGe1hD7fLgfT2AazMn1NQ3ZUbS02gpPbyk4KSooWoNlfpDj
         7mzA==
X-Gm-Message-State: ABy/qLZpnO9v5FcRcQccIpgyHub2ZvjmnFU6yJ163eXOunEx8zp51JqL
        jm0V/4Wd9fjGpX7kmFT0vls=
X-Google-Smtp-Source: APBJJlFt4g+lrGsVJ0At0ujWUAnmKQX+xrfOUKNXwyPV2Egts5nAaXzeRMynU0i7ELpyi0Pq+Z2Azg==
X-Received: by 2002:a17:90a:d256:b0:268:a691:412f with SMTP id o22-20020a17090ad25600b00268a691412fmr4999017pjw.39.1690792582075;
        Mon, 31 Jul 2023 01:36:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a4300b00267b7c5d232sm7960162pjl.48.2023.07.31.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:36:21 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        YHYANG2@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v1 0/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Mon, 31 Jul 2023 16:36:13 +0800
Message-Id: <20230731083614.6074-1-mimi05633@gmail.com>
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

Changes since version 1:
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Mia Lin (1):
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

 drivers/rtc/rtc-nct3018y.c | 69 +++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

-- 
2.17.1

