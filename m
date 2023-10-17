Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC47CBBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjJQGtB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjJQGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:48:47 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8310E2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:48:08 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 24F71C0F2B;
        Tue, 17 Oct 2023 06:48:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id DAD026000F;
        Tue, 17 Oct 2023 06:48:04 +0000 (UTC)
Message-ID: <fe2148dd4e1547a937624ebb63653ab0ccb04383.camel@perches.com>
Subject: Re: [PATCH 1/5] i3c: master: svc: enable hotjoin default
From:   Joe Perches <joe@perches.com>
To:     Frank Li <Frank.Li@nxp.com>, alexandre.belloni@bootlin.com,
        miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Date:   Mon, 16 Oct 2023 23:48:03 -0700
In-Reply-To: <20231016154632.2851957-2-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
         <20231016154632.2851957-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: et6su1xwce3dtrnwgysedozf1b4j9j5n
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: DAD026000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19nBGLglaohdnaFWs3DLGAZ7gvN1Q9+Zm0=
X-HE-Tag: 1697525284-635529
X-HE-Meta: U2FsdGVkX18ETq3OzcCKkIPupHhpUnAvv10wje3N9/qYvE1f392xyyMaj5KGvniZGbc7fo2/0vv3QM+FZi69qvrUgs8R9MBHFEPUIjzz4gOYK4+V71tXP+Xbyodzz9Os+dW/uBD1Fe2AAhfPBt1Hi7Yumt+cN32t0xEmmbu+uFhlpzpozFJipxDHpbHb8TZNZOUnJUlgDi2LOfCO26IHPa1RMYfZP/SiEZaXKa+/Bw9+lBqwXnZIF+5ZSCvpvgecnK1YJw0/OHXHg1l7KFq6W3kPkN7ZRTPQbLf8haVMzdb/mgkOesa2KQkXdOdEq460
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 11:46 -0400, Frank Li wrote:
> Hotjoin require clock running and enable SLVSTART irq.
> Add module parameter 'hotjoin' to disable hotjoin and enable runtime_pm to
> save power.
[]
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
[]
> @@ -128,6 +128,9 @@
>  /* This parameter depends on the implementation and may be tuned */
>  #define SVC_I3C_FIFO_SIZE 16
>  
> +static bool hotjoin = true;
> +module_param(hotjoin, bool, S_IRUGO | S_IWUSR);

Might be nicer using 0644

Consider using checkpatch --strict on the series.

