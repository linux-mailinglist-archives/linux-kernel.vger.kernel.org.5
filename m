Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2B756E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGQUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:34:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC62A1AC;
        Mon, 17 Jul 2023 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689626038; x=1690230838; i=rwarsow@gmx.de;
 bh=8V6nhcAhiTUMffwBIaMTnLR9XDhIFc51DT0qX7c9W6E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=nB83L19zHV+EdLVGN9ZnuY4/Iv/ASgthVJfF8mARK2IiaHIljv58UsG7H0Y8BEfiqUebs1r
 fk7rGKwSCvM0G76C1PIqCIVnHZ74L/CnMlGTO8QEjt6SJCGrHBU+QNqOuA6+LmcAjY1GKpgDQ
 BOe8RzRab/i0hLF10fSCIXW8Xycs5Og+zk/jeBZTj4Dz2xO8ifAiTN8khV6nKP+T6I9Cy0NAP
 EBGAEeaa5s04ICyyvlLea8M4G6gqYMlmEZOUC4Xc9sgkFt2vlMHcY8x5KBwjuXi/ljWtquO2l
 finfaycuy7PooC2HjIpGAPRF1KwIveoHeQt3kDJBMS+W+uOHg3FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.130]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1qaRIW025W-00PtAC; Mon, 17
 Jul 2023 22:33:58 +0200
Message-ID: <5c083de3-d4c9-c772-5fce-b225b79d5a15@gmx.de>
Date:   Mon, 17 Jul 2023 22:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/797] 6.4.4-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AiaxTZYX0agwLyKA77k719hzZAIdB3oonaUDqqpx9BHmRu/43zi
 y8ZLb+L9kpaMiEcGeQYoSaudDujrp+Yp3BjEn+7/LzR0uLbhQpicORQxZ9Jy8nFCgIeI3yf
 TxFXXMeiPDKpVPj4QNU+2KjkNBIgBjhWZqO7cVeskdx25AFgPSPJN+Cadhx135txcVpYRHh
 bNgjnGWP+GwLyBYp7GQeg==
UI-OutboundReport: notjunk:1;M01:P0:qAQrm9a0OCI=;AmS5pXjpD82U6RR7wapkPNRMOaF
 gGT0S+ilkYOjNFbD0Hkp3f4SGQhnuOYS3N8RsOy2vkmm7/fB5K4ZC5FXTcaa3f3xYSTpsNmYV
 aXCgFeS9n2ft+DQomowTNMP+8vazCxEWiYyYGY5BwgVfjpTKj8SS9422MmRBEBIMEToY/0q0b
 N3wxM+c7G+Px8IlcbmYf6VgkpcNszO6XFFkqYYr10a18luXHshV6DACBhQAw4XyDg2e+CxQzt
 ccA7NXb/SZgAdqeigkZyMBg69OGK8zEG/cQsuw9w2jnc1Unlo1zccREqJ2is3WS90MUbtexe7
 AX8YRu2nQjhjka6OBdUF5wLopetCrcc5FtbcqCKExIWHn8ggvPe/PB/rVGsBY5mM0oxY0z7WH
 Xs0DUAZNqwSPyKYnnS2Ux3cxzXPvETKqHnx2aUl3DhiS5BtKp8g35s/nQac4y3dbnE+9PRkZN
 PjUV1Zp3pjlviwhU8fqDJTdOziWP5iGX/Gl8Xz9C38NYwl4AjOIm9bUWYtTApFtFHy+YlC+8T
 FxP4hQ8FWJxYlwPuKVDqvjYr4w6mdoHa597hUcxGQcnWOmWqD90bwFNaG1L7KuaVF4LVMK1GI
 +8C/mqUaShCjnrD8RKGj0uyPkpIupCFt19xmHrpTMoNwRNGn5b6YuQ8b1FanZVpCyGqYfUXov
 kOx+5kU6YNQ3tDvjVYXf1PXPKKuxsfB01w+MIRoDd+y5bL3eOZZffuLknkuqkSMClu+T5mZWL
 955jD9oFLiwTMXVV46k+EXZrYYbn8w+Rlb3S0AJ6yHDeYwdF4bVGLCe+MXOSGUbKcW3FjW5kO
 94vkIh9zPGYFYZNp5xqlVTVeIdjsstGEOgNybegwNxWd/0PwcG9PqtsJk3J2bWhF+zU80+BSn
 LNyp2JONNx/NL40lUXS4BK8NmMInOchc9lc0dK3hg7LmGRu5qXMgZIrNZrywlEwPcK059X58A
 1iSaDQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.4-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


