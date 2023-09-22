Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1787AB47F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjIVPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjIVPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:12:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFCA1;
        Fri, 22 Sep 2023 08:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695395534; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N9Gnrmk4bmOPNG6uvMfQDG5GVQm1542nkQRai+5wmvqNYCVXbfkizABbN12ZOfbish
    xGy3uEle/WZwDYZFsAz5Rc89FpsEXY9my9I6wbg2Zh5SoBEiMpLC4CkwFNBmoflLgsbq
    FqUdTfh/62emnqZscylS212yxV9Phjon2+usJcx0xTKqOzfV/qj27S6OSTPVS0rXzq1p
    foU2b8TAWC7CLL5VnWEYt56hmJu08xhLdNON/9FY5N/2ocLs5uQ/pMAFoClRzrJgdCd8
    hpl2Njs3En48lnth1voo3MvC4Nn2VFCREWT9kHVtWRBCRmi9BrWJWkOcABKSdyAkBn7f
    eoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FNXCgqwJmYGtMx6v0T1eJMSQBj7XJ4deNAGzpzbw9Pw=;
    b=A2Gs1JCCcp5bQTdNlrzcm/ivvIq1ggvT+6wvjVJcLmw1K3umFhVQC5wu4X42sba/+c
    A6Parc1puI7cr52mpJ3/wVps+p+b9Dv5WGcD+Qfedhw3s5vRBektsBBGX7jgOe9HGNdl
    800KTSuMa7sRUbKpKX47JWxrkYXLYadPIGZfQ9yUWhSxl7iryIxyhh5XALlfF09hxLV8
    zGjmfuoGo8qC/gWPk4eP/QZT7UALaP6cMInULkApshhldoNqDAwTaRGYDsLrsWiBivQY
    oiOFrKd8Z5l4qS9Oax5sHWqfIOan4eP6BkOQldRzoefQVbnJN0eYqF8OcCFAtudQbFya
    hv7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FNXCgqwJmYGtMx6v0T1eJMSQBj7XJ4deNAGzpzbw9Pw=;
    b=ZsCtCBiJdx3goh+gG9+0olA1sjzAKOVbxzZnECBxHQpyOGHi/DF5jOKVmg0bLzEnNb
    8cgn1ti4q5c9CBj8ceMugB5wnHDlXoNHaWTHZFVPuaRRmWXBoMByBR5TA//96lwVGcRo
    i4DUmM47Ee5us7dQpru/oH1QbQfee/APCiZACpbKvp3Yy3CDHRkXO0g/oyz0xRp2wT8s
    W1D7Q/j945Lmf5+I7wx9J3p4kEfSHp2I0cpCBImOLQu3WHTDhyfklF4EP19JJTCjU7Fo
    mcHMG4oKPzfpDgRFGg+GajmrP0g7BzlvIjE9v9RBGyWYDQETUBJt3e3iPzweOvD+Sqqd
    1Www==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695395534;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FNXCgqwJmYGtMx6v0T1eJMSQBj7XJ4deNAGzpzbw9Pw=;
    b=5mxW+IgOuZAk6cQaiamjHkIT/rVjeOhRLrJk7C4zAi32fAYvWGBC6DJC11rD8NCPTT
    aJNOl2om+KtM3fUNYECA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8MFCEUd5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 17:12:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT
 overlay
Date:   Fri, 22 Sep 2023 17:11:55 +0200
Message-Id: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuuDWUC/x3MMQ6DMAxA0asgz7UUDIKmV6kYTHDAQ4HGCCEh7
 k7E+Ib/TzBJKgaf4oQku5ouc0b5KiBMPI+COmQDOaqcJ0Je/29XNmh9wMA/SYzDZgtGqtteuHb
 Re8j1miTq8Zy/3XXdsEcb/WkAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the example of the recently added apq8016-sbc-usb-host.dtso and 
convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be 
applied on top of the apq8016-sbc.dtb. This makes it more clear that 
this is not a special type of DB410c but just an addon board that can 
be added on top.

I also prepended a patch that cleans up the node names a bit.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (2):
      arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
      arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay

 arch/arm64/boot/dts/qcom/Makefile                    |  5 +++--
 ...nine.dts => apq8016-sbc-d3-camera-mezzanine.dtso} | 20 ++++++++++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)
---
base-commit: 7236e86ce5c8198b01c30933c2334d07d877cf48
change-id: 20230922-apq8016-sbc-camera-dtso-f247bea40f99

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

