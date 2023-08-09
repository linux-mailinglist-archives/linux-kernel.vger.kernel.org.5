Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32B776165
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHINkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHINkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:40:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DEE2109;
        Wed,  9 Aug 2023 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691588449; x=1692193249; i=rwarsow@gmx.de;
 bh=ih3Ac9MLUTd/7ZyXgWntILOPMDxRN7RJ9DfRFxo0nWc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=FQu0tIAFQqE5bGkbqhf8+PIo1Kia7ZYG+l+Ku2d+ujHbhs5s4GP9GeR9g7/4OCKWI3PF4YT
 KCTnt1NHwPwp/HMJeBjvxXI9uZ6rXLbP1d775OiOxLfVNqUYLw8BZeFGUyl6S5gHH2nF8jtpr
 dx6Ox6kpHyTNgQaRsCKTQ1ulLX1Z1v7kpK2g/KhBEfCO4w/rydOelJ1mMVTI/InSJklj4q+kX
 zJhg+t5rjD0/BJHpluMMEcDP6xgcNTZhdCDQPZaAWikUGWi5yNfDaWK1w5oD9oA7Oc05RdwAi
 GefV3mkeoNJbchJMkjN0l9KBHLfjqovSZ+ypsUKpY/zfu81a6BpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1qIpJY3iSO-00X3dt; Wed, 09
 Aug 2023 15:40:48 +0200
Message-ID: <5bba262f-c3a4-fdc0-deff-da3cb0dc49e4@gmx.de>
Date:   Wed, 9 Aug 2023 15:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJThwcI1HsvGBnXZrmGYcpXJf6oZNnsy59DNlYCWu8XHfeKFjJ/
 GzLzg5OjC164NUE3mbQcNFToIXaHx//l8arY6kCGv5tPcU3um868RiXEfTv+3UTfsOF//eV
 5GXAIKmdrMET2Esp3d1Bgcc86FWjXK5xRjTYIT3t7eQym1qZ51Iu/iD+p26dTmE25yAz/6X
 1JA5gkpqPfk8vGLBv810Q==
UI-OutboundReport: notjunk:1;M01:P0:lK/Daummjqw=;ztX7zhvBG/hcN4I3OQ3OHLwSAIc
 xEW9/nJ6Nl+cGSzvwxB3vrWnm99lVcn3W7u/6bZBbYztR2aFByai5TySrOt6A5szx0lHXu8r+
 gHM3emue/t6/OHe4RZ+tJBQjE0isI2iiOrZWIbmiaYp67ismQv7oRCFS67X2mc4BiGX19Ls3e
 yEoFPUE2WqnY8XjMZgsnBWiBxnUmyORDHM15L8ZjctchwiAUnyFu7ft4CO8iClQpq24lErv5d
 PKwT8y9Z2waRr0wPXln2K/EwUGQOCmroZs+cunF2MwaQDKQqUF5lJpQh/vps7PfwBXdy7FatM
 9krQeCzIdsWHHigfg7QLLGkiM2AtW48IkuvpARO4v3M4fwx3u1tLnPitBMYBHJiiLuBYJGN8O
 gfSbU+gMBWCKipSsX6sSpExyIBl4rqZ7A9O2Rjj1J3jJHlBMJxYlR0XYYlVyoLE8qy9oPOmw8
 v+/yKPnVqKXunEGBtkc/1cKXmkXl4qkpyBlKu1b2aSuPn5pidtv9kBbz1q5cInYd8gF1P7ZI2
 s8whkBfY5AKyCxcOZmtPGjwuKOFeP191r4bUxag2CCzIq6X0QR8JAWiRJKrg+ckysmspBuFFC
 yMeHOIg0kxZqMUmrpUtIvjJ535BImVG1ru8GmPVsuJ3dcpi6mQ4C0vP7IzOgRkox3JGiCgkxi
 jb2ZhBSKVSa/j+8HC8xP6/g6Y5whfbaZViojSVGflHf5OROTw2zmpnrii1oi8xb8rFgbiT9gv
 N2zs8/lQMa6dWOvu8/liFLY/1Ebzyu2wbhUzQRoR3vf5aodsLoHz+Wsb8+9+v4Kd7mlxjwfdk
 8Pu79+IEf7deiY67RHiCQmFvZ+vk2d1uS/2XfLSX2MjWhMyZVciSqS7b+c2UvDKxCZD5iu4N1
 z10V9/UhuID6C/IJhwzpx2m8CVSyvyty11E0jQMR8PPd8qendjH0BVKMfSI4wEzGqKzjaTndY
 Re6RgFTYLBFIXr/wbhxSGOvYA1A=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.10-rc1

compiles [1], boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

[1]
But I'm unable to compile vbox external modules anymore
seems to be a regression against Kernel 6.4.9

- WERROR is not set
- GDS_FORCE_MITIGATION=3Dy
- new microcode is on the box

Error Message
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
...
/tmp/vbox.0/linux/VBoxNetFlt-linux.c: In function
=E2=80=98vboxNetFltLinuxForwardToIntNetInner=E2=80=99:
/tmp/vbox.0/linux/VBoxNetFlt-linux.c:1570:40: error: implicit
declaration of function =E2=80=98skb_gso_segment=E2=80=99; did you mean =
=E2=80=98skb_gso_reset=E2=80=99?
[-Werror=3Dimplicit-functio
n-declaration]
  1570 |             struct sk_buff *pSegment =3D skb_gso_segment(pBuf, 0
/*supported features*/);
       |                                        ^~~~~~~~~~~~~~~
       |                                        skb_gso_reset
/tmp/vbox.0/linux/VBoxNetFlt-linux.c:1570:40: warning: initialization of
=E2=80=98struct sk_buff *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointe=
r from integer without a cast
[-Wint-conversi
on]
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:252:
/tmp/vbox.0/linux/VBoxNetFlt-linux.o] Error 1
make[1]: *** [Makefile:2032: /tmp/vbox.0] Error 2
make: *** [/tmp/vbox.0/Makefile-footer.gmk:133: vboxnetflt] Error 2




Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

