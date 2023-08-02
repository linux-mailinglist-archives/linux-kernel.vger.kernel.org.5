Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8976C5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjHBG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHBG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:56:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735810E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:56:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf9252eddso656859166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=l4+MfpYfZRWgAvFL59TuqxRwKN3tBGtKvfwKpSyrfRyu+7nwyMrx9ILWQWLNKf32OG
         FUtfn0xMrlGBtubo2AdyaBgxbz2yLFhQXM/dIbwDT/RowOhLwejXUk3a/OlXPawY5N+p
         q/29IRT5KSR7Jq9s0cXptycUP7XEvN+vQfND0VLUFtzxxdAADqQX27UQya7N42KpLk/Z
         rmrSsGjxpCjOlqn8F5+O9sEZMWHFFjAD46FGdFdfOtVQQWaKvWdzuE1MKSbfi98fD4cw
         +sziTQw3Q1keXmQGtd+7cgMIQ8MQg+GQZ3ttgek9Jl563UPAC+VsLBy6lZCbDaYcJ/yA
         b3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959391; x=1691564191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUzJB+BG9RWYTDdVbtJXTjUaZZLqj4Uowx0i8AONLTw=;
        b=S9dvXyuCTCh9yBPJsF0vfiJ9z+j66zXXm071Q8ZQ3f4004QUI3Brk7aXT+nQYZGnqP
         zX48RxINe9EUzGBOXmKoWHxQXNXsL0rkMny6wn0e9RO3y0Dk3ShN+2ooCSIiwwAakxp3
         daLua0Z27MribToO1Yqbthd8LIkk7ImUjFeAq5fW2KLVxKOq37iyMC91Gyf3hjOqTevc
         FMs1V2xArgyYDlB/VttcNh5U69whD6Rvzjic1mJwo5OymOquw9FChEWHkNlw6VEOBIHf
         KqMDR9F2J5X2snaSnhiYlOMyrXEqNI9TtSSorDCQPDuuHox+F8pMpXkrp9VWqh6XTR70
         mdsQ==
X-Gm-Message-State: ABy/qLa36pfMVF5B2DUsDq7dOHqqPoOGH7nuJQ0Ow58l/WuIhk7Nje0y
        7RRY+03ghH5PeJRHqOTaKSMPliPzHji8IYWFK8h2ug==
X-Google-Smtp-Source: APBJJlGi5fmP0zp7K4DR2MMoxvj+mltvijlg3OwvuFffod4okhkoMLCJtNXJIomfMjOXylY05fNUEg==
X-Received: by 2002:a17:907:1dca:b0:997:beca:f9db with SMTP id og10-20020a1709071dca00b00997becaf9dbmr4051637ejc.54.1690959391375;
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/2] Add WCN3988 Bluetooth support for Fairphone 4
Date:   Wed, 02 Aug 2023 08:56:27 +0200
Message-Id: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABv+yWQC/32NQQ7CIBQFr9KwFvMLaLEr72FcAP0VkgoNtETT9
 O7SLk10OZO8eQtJGB0m0lYLiZhdcsEX4IeKGKv8A6nrChMGjINgNe1HQfUw4xTCZKnmZwUoG30
 xkpSNVgmpjsobW1Z+HoYix4i9e+0nt3th69IU4nv/zPVmf+VzTYGC4IBcNQiKXXvl4miDx6MJT
 7LVMvtbYKXAO5QCupOQHL8L67p+AI7Xl8cFAQAA
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in the btqca/hci_qca driver for the WCN3988 and add it to
the sm7225 Fairphone 4 devicetree.

Devicetree patches go via Qualcomm tree, the rest via their respective
trees.

--
Previously with the RFC version I've had problems before with Bluetooth
scanning failing like the following:

  [bluetooth]# scan on
  Failed to start discovery: org.bluez.Error.InProgress

  [  202.371374] Bluetooth: hci0: Opcode 0x200b failed: -16

This appears to only happen with driver built-in (=y) when the supported
local commands list doesn't get updated in the Bluetooth core and
use_ext_scan() returning false. I'll try to submit this separately since
this now works well enough with =m. But in both cases (=y, =m) it's
behaving a bit weirdly before (re-)setting the MAC address with "sudo
btmgmt public-addr fo:oo:ba:ar"

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Drop applied patches and resend
- Link to v2: https://lore.kernel.org/r/20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com

Changes in v2:
- Add pinctrl & 'tlmm 64' irq to uart node
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230421-fp4-bluetooth-v1-0-0430e3a7e0a2@fairphone.com

---
Luca Weiss (2):
      dt-bindings: net: qualcomm: Add WCN3988
      Bluetooth: btqca: Add WCN3988 support

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          |  2 ++
 drivers/bluetooth/btqca.c                                   | 13 +++++++++++--
 drivers/bluetooth/btqca.h                                   | 12 ++++++++++--
 drivers/bluetooth/hci_qca.c                                 | 12 ++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)
---
base-commit: 7093f04e534f48181e5d5fccbcf99c37ab96929a
change-id: 20230421-fp4-bluetooth-b36a0e87b9c8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

