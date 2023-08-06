Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D670771577
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHFNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:53:16 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD760103;
        Sun,  6 Aug 2023 06:53:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A97F60002;
        Sun,  6 Aug 2023 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691329992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TJwmH1VAaVUby7B2ggdKHz6qTZN1WrfvAnDCRYPT2M=;
        b=LVBbhNkVmDLL8S5YYhzxmw8HeNAwsDUhfSmGoubZw5qz6fjFv0oJQS9edRoU1BHV6c+TtJ
        iuxF9lL6WcVGlSUEznhyiPw8lc9rmVsoMuvpqBLJUSzTN3CNytBCM5QEFe9HHy9lHc9SlT
        sZe4EYE3L+b7y+AN3lc686xsqVIXBo8LDUp/I9y4dszjM2NcUHh6WPVw7qzVmpFaQ/oePJ
        yGTDwqMGeT1BJYCzaRpFYVmwUE8T1vXZKuF/PvXnc6KN1dhvuipmwRhlg32XWLZ/jDdqH9
        2+PO98fIIXQjLZPsbw51xUwA4YheByP2Z1EXf9X7ny6vtCnRGX41+r0ThHuQag==
Date:   Sun, 6 Aug 2023 15:53:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 00/10] mtd: rawnand: qcom: Bunch of fixes and cleanups
Message-ID: <20230806155309.25427927@xps-13>
In-Reply-To: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
References: <20230805174146.57006-1-manivannan.sadhasivam@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

manivannan.sadhasivam@linaro.org wrote on Sat,  5 Aug 2023 23:11:36
+0530:

> Hi Miquel,
>=20
> This series has fixes for the smatch warnings reported by Kbuild bot [1]
> and also several cleanup patches based on my code observation.
>=20
> I've only compile tested this series. So let's wait for Sadre/Sricharan to
> give a tested-by tag to make sure I didn't mess up anything.

I reviewed all the patches, they look good to me. I'm waiting for the
tests. Please provide the output of nandbiterrs -i.

Thanks,
Miqu=C3=A8l
