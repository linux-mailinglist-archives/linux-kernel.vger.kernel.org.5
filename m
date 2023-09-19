Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A27A5964
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjISFdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjISFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:33:34 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287D116;
        Mon, 18 Sep 2023 22:33:27 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65646efd262so10348646d6.0;
        Mon, 18 Sep 2023 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695101607; x=1695706407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6CJxrP39FA0RJIYtQ0DaTf+T/kSY04B/ksdNoeGl80=;
        b=jcFksKOpUYuyD1kANtQ8Mn3Hg+4S0RzDzmyc6fipzF9Z9uwkElOYJPvWKvxYaLtNAM
         U8iJUnwVl2NStnKPFx7WJIPt2uvboFxslJtED/4gI/bo5hEMLin11KYzENFgIZWYtjkC
         /1whWIl5CnJtPch1l+Vvm17HcjUv3bjn+U3KniPItD+E0IqtU7AGG0NFD/L1N0Y3n8jh
         6cjR+MR0tLbxDI2IF5Upx0sva+JGkyMNus7EkqRYiXJbpv05qwS60G/Yya5FAgUOo0cM
         echWmBrCU6gO/7aA2FQqLBREHh+zBrscykXkeUmoXp74EmqGyUlKIYy1KOlGK7s/bblG
         uG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695101607; x=1695706407;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6CJxrP39FA0RJIYtQ0DaTf+T/kSY04B/ksdNoeGl80=;
        b=j+S/83Pq6RKWi1jKFh0aCdYCxBUkzZcVVVxTtc4jkldnHlbpm1p/kMRM1R9l6WsUxR
         BXzPw4748ntRYv6iZ6W5AlXW3aX0Zw/OfVQKOjV9peh8w37ZPE9j8DONdbgksApUtcob
         VQg8QZm5UwMGh7scKI08XkV7rGlYDCehj4llNSzj8c00SGpMMog2PGe6v+GoatyZR5xi
         08/z6K/gldVoSXjl45y1m1Wx9ve9fk28Aa1tp22PrN2elmOLcTarISR+Ds6oxR/GxaiP
         XhMEeGP6lAAuDYH/rBl1P3htQa0BzFf/pt65bXXYKMVg1AcB61DhbtAcPZN0JJJb3OcS
         Zjag==
X-Gm-Message-State: AOJu0YxyPl6mJk8SQ/TvHox+6bq8T9sHv8UmYnMe4d0h0VSVAjmEuuAs
        fipXDh1FP75DK5dZjluGQFlv9agyuhYCPyc0UMU=
X-Google-Smtp-Source: AGHT+IEizrrWThWGQwO+TWmVrUzQ4m9A9GjKVxvBozwovD/R/6RCeuEgcPfwZON93QqHEnPwMyNFDyG4DsEss06cew0=
X-Received: by 2002:a0c:f001:0:b0:658:36ff:af17 with SMTP id
 z1-20020a0cf001000000b0065836ffaf17mr2426548qvk.18.1695101606670; Mon, 18 Sep
 2023 22:33:26 -0700 (PDT)
MIME-Version: 1.0
From:   Chen Wang <unicornxw@gmail.com>
Date:   Tue, 19 Sep 2023 13:33:16 +0800
Message-ID: <CAHAQgRC5-tSnUZXHxTeVDhYK1m0XCzXho097bV2Awj-6XJ-UFA@mail.gmail.com>
Subject: Question about writing binding files for numa
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor@kernel.org>,
        "xiaoguang.xing" <xiaoguang.xing@sophgo.com>, jszhang@kernel.org,
        Inochi Amaoto <inochiama@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chen Wang <unicornxw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am working on writing dts for a new SOC - SG2042, you can see
the changes on https://github.com/unicornx/linux-riscv/commit/ee862fc4ebeade32bff00ad014d6b0513c0942a7.
This hardware uses a NUMA architecture,  so a "distance-map" node is
added and several "numa-node-id" are added for cpu/memory. The problem
is I find there is no YAML binding for numa, I only find
"Documentation/devicetree/bindings/numa.txt". To pass dtb check I want
to convert the txt to yaml file.

My question is: how to handle the "numa-node-id" which is listed in
the numa.txt file. To my understanding, due to cpu/memory node need to
contain this property. I should find some binding files for cpu/memory
and add "numa-node-id" for cpu/memory.
For "cpu", I find a
"Documentation/devicetree/bindings/riscv/cpus.yaml", where I think I
can add a property of   "numa-node-id" to. Note the SG2042 is a RISC-V
chip.
But for "memory", where should I add  "numa-node-id" definition to?

Regards,

Chen Wang
