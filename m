Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4F7A3E0B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjIQVsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjIQVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:47:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C7116;
        Sun, 17 Sep 2023 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694987242; x=1695592042; i=rwarsow@gmx.de;
 bh=5rl3H6QkQt9tZhh36fqYWER8mpe2IdYsDlscVKcBSKI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=ql6Sxal0k9B85lXEf79JAeAKAVTMONnEnBafxT/btivFTZutOwRuM4wls+rETRiXg3SIYCawQQK
 HgRzXeZvql9E1+RrDVJAav1m96irkXVMbDu5RwXtR2NA6OMC6uL+rKBiN7Xv0bfqzBjWtJL6ZFtUm
 dqDHDeuCWKSvwzwPn9oJTzBK32k6i9zLlZmWbGAzFiOvj/vL26bP5siisyJRb3okZsKnckZxKKzH5
 VDMshEtNdxCKa9uSGWD+FvbuONMoce0ubeaQiBxXEGSGVK+fvy+WRGbfttHv2graGAjstuKly3Sm1
 vsRILp0KVVDOSaWJlQaVggigCduVYkyhy/fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1rJXHe2zm4-00bchu; Sun, 17
 Sep 2023 23:47:22 +0200
Message-ID: <938bdb77-022c-87d9-d03c-f328ada4639d@gmx.de>
Date:   Sun, 17 Sep 2023 23:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:j6BoztCFQv5+udPsEuGUNYp3AS18A30iBVjkmBsS8uuSFdgm1vE
 QvtAjnyekMra7rtKiNWJMQPPUxmjdgNSKDslotC92WWeECedOPzN4LeWyxx04+5aSuNcqZi
 zo0YZmEJDgL9/FhbzHT9XZRxDRHJbFQRSrEF7MIp7zCqeTN1NSpah/Q25Q5Ml6ZqAZ8UaQv
 fzmKEYsHPDpSmUWpwAVOg==
UI-OutboundReport: notjunk:1;M01:P0:CyoSbCiadYk=;J88NAEsiktNmlAtt6pJUoiW0xUa
 imRn2/qWeUVTl+4uqtyXUW/LB9+MK+BH4cxvtKYRZxG6teocaC+RHZU4cwTTC28qzkrRkLyeh
 p/b1QtcLXweBJy+W3xu0tCa9ugijApAKRWbcq46mKF2cCYNu1m7xr1UoAXJbyW++zhQKsgoOE
 +nSNvBIcSsZb4ICHEzO7Cao7Ob3Ve5a4AKPDm9i1EkwuUR8HbJsKMBs7GqND1Bjp6/kMrZLc+
 zLoPFhg0A5T/2VoyNh93tP4Yc6RfAMvRaYgpx5C3olrddrTkryI/HavXDHXnFpn4YuswXR4Px
 EiCw94p43GyhcoMS1pWaxIP1IBGTtONUoepIZb6aNxwuqh3bsf9wDrjcFvT5qj/UFImmMljM9
 QKP86kV03xvzAGIZulQ+4sg/cwRTDXCInlUEDmbAAkp0yPXEJQKM6rfe626SVKFmpBDV8oUdX
 Xa6M7l8fsDj78WMADipI8Ny/Ns2+eEWZMYOyi+e90ahS8asKhYCvDgIKv2a2TWo9IJU2IOOfc
 57m98lZ8rN9zVeCvkRXYNNoSodJO7VlH+o+pMXX8pHOO2EIemMFuXgwrcw5TZR7xZeoh15G4h
 bEIh25e6reI7yhn8jhhnKUtLmjIlVrjYDwrsJrJdZEgEH+xnolIJLh+lgT2kYbzd47S5lih+G
 B+pxjfnw9l4q3F9plSv5ou+vz0yUqSSiDKTaGq+eISC7GuSvN4UHgYn5yxRyFOM6n4DExa+tK
 UCKLMYT1zSJI8+AHcsiqKXAjh6IQgI7htJaSHneqITSaglG95oxw20eIsAolrLb5hIYE5S7dU
 XZia0m7garkFU1zC9BCtnpjAjDu281xfMWxPMnQi0VPyVjhTSAah7y7F/syhVPofZL0r54e/P
 0BLNOBCw0stdVF5ps8af+6rzyC0xLjd/Ckn6SA7Ch2LyeCY/BdGOWR+nPBmT7wqYWhGbvNE7y
 I5s+HatNgTnpker5o9WfCPxn7lY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.4-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

