Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2977B7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHNLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHNLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:39:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F097B5;
        Mon, 14 Aug 2023 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692013185; x=1692617985; i=rwarsow@gmx.de;
 bh=NG6k9X7klRMkIBh+/S+/2wZrGgcEWWRW3tglTB7kwVA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=mQeYKnEJnFAsStet5vpebdBIiCCGaC4vLnbgqNi+4f89eyddUBtvn8gUA2P4Q39VkLZhXgT
 hjqDN4+ZNxKLMQ/ElNjbg6Vga16Kk399kFYvdzGsSB0JTZRT7Z8YLS6aPS0TMH1sIIfC0CY7m
 Gy1nfUDUybtFpaq9UVIUG+KHc35AGBaPO5inI1IGxjpAwJ6Q4U3zHEOiy2ufGQ0lT4anPTrNW
 Ov8MqqQHaknHWJ4ZkVzX6v1vwBvRHeMPqEYyAkiXJ16us6n6GC2vvlFoFlIB2J7jCThJlvCQS
 4SYZeCPP+qxK1CZRn04jDJ8c5z3kqtaUCFVRJd4J5h6amRBMdrDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.47]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1qaU103sxi-00Eych; Mon, 14
 Aug 2023 13:39:45 +0200
Message-ID: <808f7adf-1c12-16ef-bc22-1a6c0eb936ce@gmx.de>
Date:   Mon, 14 Aug 2023 13:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GinBVPv5X8uhCiBvh9LZfqUeH9mLIeDZVIUAz/0bOotDFd6kG1e
 znnoI3eapXlElZS/7yPBx3oLxETAwpwNvuFrwX/HSKMzxfKmiMNT5o45d2A4PLPKG2eZ9Ek
 y7SWBFOx3amqADVJIjouUJ2+RxQOThxrjjHxopnKCNwIqf97uul/BVfwGrHWFnVrpcPud2n
 a9bHw7COL56Gcx5t34WWQ==
UI-OutboundReport: notjunk:1;M01:P0:x497veXkylU=;hNjUwydSvl7FPbpYX9g3fe7lCtL
 aNzBqUbGILC8ddPvuBsps5wQ08/+TQJJ15q18E2JKkzufzvvBYSf+5NUy7+p2Arz1rI2kCqKz
 dl80VYcJMxSQIWnLCesu3M+XEtZ4WyahDO96OcDBdSlEkGPAXDJQ0GYC4gwHM1Q+dvC75rILn
 bNRFpoI9+wyht0THOd902f6tJb60WsWQ/IG/iOyPgmhIumRA2rW+QgBdmfKUh3461EWi1aJbG
 LZGbH4giWaemgTHCfgfXfT5UGhtr7vxbmXz3Q6MlY0BpCSoQtdzsL0vSLJajVjKdfuIL/fyGh
 oUlsaEQ+LYDHe9sYOvcn88hafxwW8Wqejck5AMAvIMG7meyxonhshLcXpiMOekJVHRfJ9O5HJ
 xPeGJo3i9vm7Z8rZ34BnhXPGieZGH6qfcuyEUuF306+1WeJYT43paAIg+4y2/02ts542qQeOX
 e/yynGvHQ3KqLNZBL0akz5CLlKHBT/ugOAP3vr0SuDM6ntD8Oa3pUtJ+hxOM60eZhfLHtYyBK
 wy/CeakppfN7xoJbG5coBFwTmnIliyW9KcaxLrSxp6SuBgp/4fost4ZwN2Te4e1dFDs5jTtBl
 kpePwgHM1o1fQyAJUQUG4sY493FOmtH+MIfVUZJSf7tVJbx1aHzRcf1+AtbeCILOVZeG4sL6c
 0l8OeX/1CxEs/9R4dVCuwxYtu9mD6R5yj4eZ+c80Hg/TsDDfRAe0whFk81CMQ1u2D2F46tqEQ
 JowHle+CmALTSxs9JY/0XXxEh/peuoIlEqP+Dtn4qwZDzCW5tmrsONWBF37UsPzei5T/AtmlH
 fNwKkiSy1WlT5+gkon6FLMBRGTsvbtIh3wp9cyfcOuRCmbCHKgUIASyUYkzt4d96TMFqlGgpo
 r6T3WVsEP6ex3uwrRDhjLiWMdsy9uLDFPHSlyq9XSOKT/8NAhVrDjf2wnVKO4MXnYt8D7gDJH
 e20gRA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.11-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

