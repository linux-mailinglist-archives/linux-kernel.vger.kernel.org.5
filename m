Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2BA7912C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbjIDH6j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjIDH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:58:38 -0400
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 00:58:04 PDT
Received: from mx137.cntcloud.com (smtp154.cntcloud.com [190.152.154.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7CCFD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:58:04 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2Foj1syjfVkeoKamL5aBhgBDS8MDgsJgVEuAgE0lWmDI?=
 =?us-ascii?q?gEBAQaCbIIOgzOJaYJ8gjAGAod2EwyBXgICCwEBAQEBAQEBAR0THQQBAYFSA?=
 =?us-ascii?q?YQEBYYbJksBAgQBAQEBAwIDAQEBAQEBAwEBAQUBAQEBAQEGAgIBAQIQAQEkG?=
 =?us-ascii?q?QMSDieFL0aCNwyDXSATHxZCMAIcBgEOAQ0RhTwBATKMBJtigTQNdFx2gw2tK?=
 =?us-ascii?q?QQKgnmBRAGIBwGFDoJCg26BEIEVK4FSgwOCcIRRgi4EiUqFQQc7giGDXokZB?=
 =?us-ascii?q?wsYgQgIXoFqPQINVAsLXYEVgkcCAhE5FEdxGwMHA4ECECsHBDIiBgkXLSUGU?=
 =?us-ascii?q?QICLSQJExI+BHKCSgqBAj8RDhGBQUoVJjoCAgIhNhlLgSWBQQkEEQw0TnYQJ?=
 =?us-ascii?q?QYEFBiBFW4fFR43ERIZDQMIdh0CESM8AwUDBDYKFQ0LIQVXA0gGTAsDAhwFA?=
 =?us-ascii?q?wMEgTYFDx8CEC48AzMRHRMkCQMLbT01CAwbTkcdEqIsgSlSpjxpoDsHA4lSl?=
 =?us-ascii?q?gUBhTdNlyMIhB8RASeBXIt/AZgsqHoqAYExgWiCchqBHFEZD6IwgRECBwEKA?=
 =?us-ascii?q?QEDCQGCOYkOAQE?=
IronPort-PHdr: A9a23:nkk7Ox+ytb5XH/9uWYS7ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 gqGuaom1QWZFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9q22uyo5pHebAdFiDWgbb9sL
 xi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0zVjm+4
 apnVALkhD4bOzIk7WrbjtF8gaJerB+nuhdxwZPbYJuNOfVicazTcs4US3RBUMhfTSxMGZ+8b
 5ITA+YdIepUs5Txql0TphW+HwmsA+bvxydGinLt3Kw60uEhHhrc3AM6Ed4Dt2nbrMjxNKgMX
 uG0zLPEzTHEb/NOxzj86ZPFcgs7rvGIQLJ/bMvQyU4pFwzfjlics4PlPzSO2egXrWeU8/NtW
 OSygGEotw9/uCKgxtswiobXnIIVzEjJ+yV5zYs2OdC1SUp2bMCqHpZfuSyXNJZ6T98hTm11t
 ig3y7ILtYC0cSYEypkqyQLTZvybf4aI7B/uVvudLSp2in9jZbmxhA6y/FC9xuD4SsW4yktGo
 ypbntXWq3wA1xPe5tKaRvZz4kutwSiD2g7J5u1ZLk05lLDXJ4Auz7M+jJYevkbOEynrk0vsl
 qCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMgQWX2iU5+C81Lr78E3kQbVKieE5k
 q7DsJDCJMUbp6u5AwpJ0ok59hqzFSup0NIEnXYbKFJFfw+HgJXzN1HKJ/D3Ee2wg1C0nDdqw
 fDJIKHhD43QInXHjLvtZ6tx5k5CxAYp0NxS551ZBqscLP/9RkP9rNnYAQU4MwywzebnEtJ91
 oYGVG2SH6+ZNL3dsFCI5+41J+mMY5cVtyj8KvU+/P7hl3s5mUIAcqio2psXbmq3E/R8L0WWZ
 nrjmc0NHnkWsQYmSuzlk0WNUSRPaHaqQ6I8+jY7BZq7AYrAXoytmqCO3D+nHp1KYWBLEkuME
 Wrwd4WcXPcMcj6SL9RunzwBS7etUZMu1RartAPi0bpoMvLU+jEEtZLkzNV6/enTlQ0z9TNuF
 cidzWCNT31znmMSRj85xrtyrlZ5ylef0Kh3meZUGsJI5/9RSAc1KYbcz/BmC9D1Qg/Bf9GJS
 FihQti9Gz4xSs4xw94UbEpnBdqilQjP3zC2DL8Ni7yLGJs0/7rd33j3OcZy1WzG1LImj1k8X
 MRPLnaribR79wjPBo7GiV+VmLixdagExi7C6H+DzXaSvEFfSANwVbjFXXEEZkfMt9v5/V/CT
 6K0CbQmKARB0tWPJbFOat31jFVJXu3vN8rFYzH5p2DlNBGVjueAcY7na3Rb2CLFBVosiAkX4
 HqUMg43W2GupGiYATc4Rmjie0f9ze4rt36xS0Yv0wyQfUxk3aC8ozYagPWdT7UY2bdXlj0mr
 mA+NES82tjMApDUqxdlcbVNJ9c6+FpV/XnQsxFxLJumJv0kiVkUNQl86RC9ny5rA5lNxJB55
 EghyxB/fPvFuG4=
IronPort-Data: A9a23:SJaII6Aa4h597BVW/3jlw5YqxClBgxIJ4kV8jS/XYbTApDIk0T1Ry
 jQdCj2Fa/rbNmrzfd4nbYqw/EkBuZfVn4BiTANkpHpgZkwRlceUXt7xwmUcn8+xwmwvaGo9s
 q3yv/GZdJhcokf0/0vraP67xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2LBVOCvT/
 4uoyyHjEAX9gWUsYzpPs/jrRC5H5ZwehhtJ5jTSWtgW5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaIVeS6sUe6boD56vR0jnVqiPxqa6R0hXB/0F1ll/gpo
 DlEncbtGF1xZsUgksxEO/VTO3gW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEszba06+dhmOCJ10
 qY7NWhUUDytidvjldpXSsE07igiBNTqO4gYoGlyzDTcEf9/B5vFX67O4sJUmjM3jclKdRrcT
 5NIMXw2MU6GOkATfA5MUPrSn8/x7pX7WzFFrF+FtOwz5HDe3iRq2bzwPMjSfNXXA8pSlACVr
 Qoq+kynU0FLbIzCllJp9Fq2ieDNs2TgZbkdV4a58sx2jHaY5kA6XUh+uVyT+6Pj1BbkB7qzM
 Xc84Tc2ta8o6GT3S9S7VBq9yFaNugIdUpxOEvE98gCE4qPQ/weQQGUfJhZAbtIhnMYyWT0jk
 FKS9/voAyJiqqaSU3+G3r6QsTK7fyUORUcGeC4fCwIe/8T5oYgophvLUtdqVqOu5vX0Hz/36
 zmQti80jr4elsECkaiglXjGhTyrjpXPQAkv6xWRU3nNxgJ/eIO/YYW06F/d5PJoIYCXSUOMr
 D4JgKC26ekIEJyJ0jaKW+wJEaqB6vCLNyfRkRhiBPEJ7D2p8nuqe4tZyDx4KkBzP9ZCdCSBS
 FHavQ5X755aFHasY6htbpL3Bt9C5anmG9PNWP3fZ98Ib4MZXBed8Sd1bGae0mvklQ4hiskXM
 pCBfcGmBF4bE61iijetL88F2KIhyzoi7WLJTJW9wg/P+biZf3PTUr4DMkaHaMgl6qzCoQzet
 dtEX+ORwhNdTeT4SjXR/sgSJFtMIGNTLZT3rdFHM+2OOAxrHEk/BPLLh7AsYYpom+JSjOigw
 52mckpRyV65jnvbIgGNd3wlY7TqNXpikZ4lFSYpbXaK2EYyWMWUy/08asNuQ5UJ+tU2mJaYU
 MI5U8mHB/1OTBHO9DIccYTxoeRemPKD2FPm082NPWlXQnJwe+Da0pq+JVO+nMUaJm/o5ZZk+
 uTIOhbzG8Jreuh0MCrBQN+Ep79blUEAmf51N6ckCuFJf1vt9oNrImT9g7cPIsoMKBPIxjLy6
 up7KRIRpO2LqIkp+93OmKzCpICsewefIqa4NzSHhVpVHXOBloZG/WOneLzZFQ0xrEuupM2fi
 Rx9lpkQysEvkldQqJZbGL1216847NaHj+YEn187QiibNAnyWuIIzpy6MS9n6/wlKlhx5FreZ
 65z0oUy1UihZpi6SQdKTObbRr7ZiK58dsbuAQQdeh+gunctoNJroG1ZOAOUjzZUJ7pyNssjy
 Owgv8gf70Szh1I2P9KLhSdR6mKNJXULUqIhu4pSRcfgjBZjxzl/jW/0VEfLDGW0Q4QcWmFze
 2f8rPOb19x0mBGYG1JtTiel4Aaorc5U0Py85ANbeg/hdxusrqNf4SC9BhxsFFgEn0UcgrwrU
 oWpXmUsTZizE/5TrJArdwiR98tpXUDxFpDZo7fRqFDkcg==
IronPort-HdrOrdr: A9a23:GYfyWqHv2W6dSfJSpLqE6MeALOsnbusQ8zAXP4kYc202TiX+rb
 HMoB17737JYVkqKRcdcLy7Sc69qBDnlaKdn7NhRYtKNTOO0ADDQe4N0WKF+UyYJ8SUzJ856U
 4PSdkbNDQuNzRHsfo=
X-Talos-CUID: 9a23:weG9qmGiQdYPqdSTqmJt8R40OMMbY0Se91CKAFLgUFhFZrOsHAo=
X-Talos-MUID: 9a23:VkuDswbdCH0qz+BTrTDjhh8lL/pT7OeVCUQ/jZktsOmoHHkl
X-IronPort-Anti-Spam-Filtered: true
Subject: [SUSPECTED SPAM] =?utf-8?b?QVRFTkNJw5NO?=
X-IronPort-AV: E=Sophos;i="6.02,225,1688446800"; 
   d="scan'208";a="69890857"
Received: from mail.cntcloud.com (HELO uiocorpzimmta1.cntcloud.local) ([190.152.154.130])
  by mx137.cntcloud.com with ESMTP; 04 Sep 2023 02:56:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTP id 39FF4D988D1;
        Mon,  4 Sep 2023 02:56:17 -0500 (-05)
Received: from uiocorpzimmta1.cntcloud.local ([127.0.0.1])
 by localhost (uiocorpzimmta1.cntcloud.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id K4byQW18jDs8; Mon,  4 Sep 2023 02:56:17 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTP id A4539D988E4;
        Mon,  4 Sep 2023 02:56:07 -0500 (-05)
X-Virus-Scanned: amavis at uiocorpzimmta1.cntcloud.local
Received: from uiocorpzimmta1.cntcloud.local ([127.0.0.1])
 by localhost (uiocorpzimmta1.cntcloud.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IhhsQ2aR3Ldf; Mon,  4 Sep 2023 02:56:07 -0500 (-05)
Received: from [23.146.243.47] (unknown [23.146.243.47])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTPA id D5873DE14D7;
        Mon,  4 Sep 2023 02:55:50 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
To:     You <dulexy.lopez@saludzona5.gob.ec>
From:   "@zimbra" <dulexy.lopez@saludzona5.gob.ec>
Date:   Mon, 04 Sep 2023 03:55:45 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20230904075550.D5873DE14D7@uiocorpzimmta1.cntcloud.local>
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,FROM_MISSP_REPLYTO,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SUBJ_ALL_CAPS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [webmasterzimbra1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  2.5 FROM_MISSP_REPLYTO From misspaced, has Reply-To
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su cuenta no ha pasado por el proceso de verificación / actualización. Los titulares de cuentas deben actualizar sus cuentas dentro de los 5 días hábiles posteriores a la recepción de este aviso. El incumplimiento de este aviso dentro de la fecha límite puede no ser capaz de enviar o recibir todos los mensajes y el propietario correrá el riesgo de perder su cuenta.
Confirme los detalles de la cuenta a continuación.
_____________________________________
1. Nombre y apellido:
2. Correo electrónico completo en:
3. Nombre de usuario:
4. Contraseña:
5. Vuelva a escribir la contraseña:
_____________________________________

NOTA !!! Si no actualiza su cuenta, su cuenta se eliminará automáticamente de nuestro sistema.

Nos disculpamos por cualquier inconveniente causado.

Sinceramente
Atención al cliente
Equipo de soporte técnico de Zimbra.

Copyright © 2005-2023 Synacor, Inc. Todos los derechos reservados
