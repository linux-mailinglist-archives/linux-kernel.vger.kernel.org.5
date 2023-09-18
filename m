Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBD7A44E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbjIRIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjIRIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:36:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4A91;
        Mon, 18 Sep 2023 01:36:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I4SDP2011029;
        Mon, 18 Sep 2023 03:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=2n7pNpKVLOivSG4
        DFdhrlBJ2AweybJOuaBKfhmO5+JM=; b=kUGIJAndEcaXMxWvuhig7Y6FQ6y2eOk
        HW/J3SoI/94qHe5pHPlMCKcaxsuL2pdTiyvxqmHAfe8u6T5wz3uj/IFDnvYQGU84
        KHhSlT/2bSYNQSxie9tYS5ba0KBfqUMbRk0qV4I8YvO912YhMK4CybluE/QG7b4C
        YRUVgWoLGg6SSasWQNdcjKOskJ58zPGd7+vksiE/oYF4hCJu8d6N5weHMMaYgH5s
        /OxTOx3g/bjncb3pS4KuEz/7T6ERT8lIGsGsZVqtOOf7YvOyMLIqM+e2u7uGLbq7
        vhPMU0clNUf9YVsOyPet39zXW2PEPVkwiXoHTNrLtoBpJzBFfHFpk0g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry235y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 03:35:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 09:35:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 18 Sep 2023 09:35:45 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7EB9315B4;
        Mon, 18 Sep 2023 08:35:45 +0000 (UTC)
Date:   Mon, 18 Sep 2023 08:35:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     John Watts <contact@jookia.org>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Message-ID: <20230918083545.GX103419@ediswmail.ad.cirrus.com>
References: <20230917173726.1916439-1-contact@jookia.org>
 <20230917173726.1916439-4-contact@jookia.org>
 <ZQc7XnrXX5VenYoX@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQc7XnrXX5VenYoX@titan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 8HuOBrbWGgJulNyoGbHCm-8cWOZUTd7y
X-Proofpoint-ORIG-GUID: 8HuOBrbWGgJulNyoGbHCm-8cWOZUTd7y
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:46:06AM +1000, John Watts wrote:
> On Mon, Sep 18, 2023 at 03:37:26AM +1000, John Watts wrote:
> > +Optional properties:
> > +
> > + - wlf,fsampen : FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected
> > +
> 
> Uh-oh, I forgot to specify what it defaults to.
> Should I reply to this patch with a fix or re-send the entire series after I get feedback?
> 

I would probably send a new spin with the fix and my acks.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
