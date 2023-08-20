Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D378202F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjHTV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjHTV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:29:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EEE7;
        Sun, 20 Aug 2023 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692564475; x=1693169275; i=marvin24@gmx.de;
 bh=UqSdzhzgDMynAd+cmKiCvh4no7cVUic+d0Tx96GVAPs=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=lg0/7qNrvuKuMLcZ21agSVPnw8VRAXyGNZu4n+DHffKL+SAIgHM7NB9wNjaL1vBVsLPMVyW
 PaMH0bORQemiFznjRqvUuBco9XSskQJYyMBK/BE7V3W+TWPrwNuCZ+ONUtU9RSuipAJrdHqpB
 BKnq2rdmcmhecBNu1HjPx0gicEehz6SxL/osOWG1VDVQCyHtfKSZeCj69P0g8r8kh+C+TRwZR
 /SBilVxI470rXn2PsF/jKELSk+JwCTpk8BnmqDWGNvOr9IaLZXJcpL3RtjdXVm6bA7aBeGPci
 FUWNLss8ozYy9wFcXOF0qXx/yOQ8Cic7mwR3QDuvtZDCEfpJ64AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from n5219w05.fritz.box ([92.117.212.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1peYm80zGd-017EUh; Sun, 20
 Aug 2023 22:47:55 +0200
Date:   Sun, 20 Aug 2023 22:47:54 +0200 (CEST)
From:   Marc Dietrich <marvin24@gmx.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, ac100@lists.launchpad.net,
        gregkh@linuxfoundation.org, marvin24@gmx.de, alex@shruggie.ro
Subject: Re: [PATCH] staging: nvec: paz00: remove unneeded call to
 platform_set_drvdata()
In-Reply-To: <fb1cc561-926e-478d-a6ce-9d97fa0dd0e1@kadam.mountain>
Message-ID: <d772f63c-ed2d-ce3a-e466-eb2d2d46f700@gmx.de>
References: <20230809154211.15741-1-aboutphysycs@gmail.com> <fb1cc561-926e-478d-a6ce-9d97fa0dd0e1@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:YakV46+WJwdGPCWRBnz6aKvQNtkltFPA+uQYZs3owXYf6lzGo3b
 PhrzvSoD6AOslsMbuJqI1pFBUMpOkfaV5OhOJHCcggfaqxNu+jd78yjWdCwZnla4Iwj5zHu
 1qCFoDZ3uVk8Un9BVIzNpPzMFIRWmiohotWLYNTLIK9tpy1SM/GmGvtlpmkO18TTMnZj1KV
 vDrU/8EppClUw2Xe3kceA==
UI-OutboundReport: notjunk:1;M01:P0:ZfxN4xRr7iQ=;tyMI1esC88vfMqYJR6jampCCJ7+
 fC6f0Lg1nzc2allvz3NVzvgVr3SeVr/ZS37ykwuHMqwFBD24RxzGWyb/P8kYFyd48YWosah86
 ewlewQxEyWWXPRgk3v+Cc8Ou/0su1u+N7AOSOg34AKeJK9bQjUh+XzV3XYvWU9YAlyJdaeXEC
 azoCC2NeZ1IX3FP1UN1OjmllQ6opNFh+gPRUa6P3X14dJ4eq82hoZzsVU/OgqR6cZF4krGsSd
 uaObR2AHge+ENQJMXUGoQ0+JgflUCRSs1BvXQvhI7s6h7aOpmZgw9m2WjNC+OuJDX4jGJak5H
 besPx7qTFvqNsppg9CnZhGWyWRpQN0r3+TlS1aRmX8N2HeCd3o8enOgDYhF0IhoI1hIzQeoPB
 YZSGsPzLA/bU9jAfhqS40CjPTa8lncDh0byKdW7n9NDFrBkF2UNgalKAHV4BNK/cjX5pi3MSr
 FHnJG/RLgeWAELyYTfk0VyvnGNfAQOooXRj5XHY4uTJEeYYeNpYh4V6ibyqXlWkig0pZ/tGiY
 Q3g8mapx9M+h3ZwMBNPji8Og5gcmLqEMMP0cxkNkb/xiByukR7VwTsN14nTVeI+o5dylSFpTf
 AKNK2n5bD69rY4riq/0IePo5vQpiyChEPrIGMEYxSmoMtBSXkox0Rr7YgEjeOUtb/JtMo79sP
 zlVQiB0hPPSeK47oqRd73xXB3tl6QwGa6T0FVa6h0xZS4zaNjUndxybRJpjhowGXcqb9ekY9A
 lgnBSntB0TPuIU2zOCOQk7lHMgqDqqabYSFWqtaTs7EQMRoDk753bJX7mxlcpRJNwPfvH5TzI
 7lPIFDglOMe4vRiDp8wjb+q3zEMqPrEWUvXNY7qCTcw79+4EGc9bX/kmtiNv3WJQc6afss8Bd
 cdpHfO7p67Ve9+Wxc/WU8gBLwzhgnOSFkUUNkoNh/Bwde1OvHocHmB608chO0cWy8j651TOMc
 AanymQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2023, Dan Carpenter wrote:

> On Wed, Aug 09, 2023 at 06:42:11PM +0300, Andrei Coardos wrote:
>> This function call was found to be unnecessary as there is no equivalen=
t
>> platform_get_drvdata() call to access the private data of the driver. A=
lso,
>> the private data is defined in this driver, so there is no risk of it b=
eing
>> accessed outside of this driver file.
>>
>> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>> ---
>
> I think you are right, but why are we doing this?  That one line is
> hardly a huge eyesore.  It's all risk and no reward.

I guess this was placed in order to implement a module unload function,
but this was never done. The driver also seems to have found another
method to get its private data, so this can be safely removed.

> Have you tested this change on real hardware?

I just checked that it compiles and works on my AC100.

Thanks!

Marc

