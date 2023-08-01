Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967A76B3CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjHALup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjHALum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:50:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A2C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:50:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso64267481fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690890640; x=1691495440;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8anjLa3fQUuKSMyWGBixY8Ld6aUbLztV2CllbGNquY=;
        b=A/yr2aOif3EMiR70/Mx5jAG1KdZ4BkNilH8v1QkqUAC3Txao/eWXpHpEALjUfR8umh
         WOUWvfnAarvJ78byX1ASMChmLSR5GgzlfBw2oLCy3SBI8g5PDkTv7clPuhzMgCJxxi7g
         3FK6MMPINK6S2TpSJFnyzfYJmjLkHv8ULmGT/K0dIHEPv4TX14ohtEP0lZEGDvouNK3v
         rdm2I/BEC/XCJxp/ArMuSEOTwz1GUzhyaEzS3UJfdinem7ZyDYRyVz7T0Lle01s00IMN
         nHoTWNvimas5OjoWYWoBN2FQ0Wcjy3lJhk+p/9S5cZzLcLlwmfL4UHRSIpdwjP9NejZw
         fVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890640; x=1691495440;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8anjLa3fQUuKSMyWGBixY8Ld6aUbLztV2CllbGNquY=;
        b=cG8WXwlbnM/ZFwNlRU5opkwNxSlr5p7qgNAAII+0cicvh/6ssEZR/eZqlwn0jJl6Vg
         532asypjSQMX3bJr1y/iRdxAYx7Wjj5utPyXtMjVbxlY0QzB8LWvYBg0kyi7kHv4gche
         WOXeuQXT6RDqFlukA6GF+JYOBo2GGbui2KJdt2N22DcqqVh3cURCR9iheAJKODR/k150
         26GXH+DwhoQIY2DuStt2ZkO+zGbxZmJOOabUdm+46akK0h9vALJNYeTKPXEooCEm9SxK
         1UCPuh3ma5NVGoUXXtLMQ65HjAAhKiHEvCiLdyULp77W3sso1/TfGy3fk/SylmymHqmJ
         xoEg==
X-Gm-Message-State: ABy/qLbrbktBEXGYNSpbIm1fVWLC6bCfhvca9UMtvxf7KiYL9W9Sxi4X
        Mm9eSR1dkw8mrmEIuCW2hd29H0xJ0QJCsF55sJU=
X-Google-Smtp-Source: APBJJlEARoKJC+9481EAtjsdyva2knzBsuQTlkq3GFnfjatdXfqlmvabK5uuexmtwUcf+0WA+WIyics5D3Z9k3kktBM=
X-Received: by 2002:a05:651c:104e:b0:2b9:dfd0:c3d5 with SMTP id
 x14-20020a05651c104e00b002b9dfd0c3d5mr2179327ljm.46.1690890639646; Tue, 01
 Aug 2023 04:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:12a4:b0:253:3d45:4dc8 with HTTP; Tue, 1 Aug 2023
 04:50:39 -0700 (PDT)
Reply-To: hegborkodjov@gmail.com
From:   kodjovihegbor <franklinvaletine50@gmail.com>
Date:   Tue, 1 Aug 2023 11:50:39 +0000
Message-ID: <CA+17ep2nOT7rTjoiQib8iLW6i2j2XLuE5noovqTNGG512hdHWQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

56eB44Gv5Y+L5oOF44KS5o2n44GS44CB44GC44Gq44Gf44GM56eB44KS5b+D44GL44KJ5Y+X44GR
5YWl44KM44Gm44GP44KM44KL44Go5L+h44GY44Gm44GE44G+44GZ44CC56eB44Gv44GC44Gq44Gf
44Gr6YCj57Wh44GX44Gm44CB56eB44Gf44Gh44GM44GK5LqS44GE44Gr44Gp44Gu44KI44GG44Gr
5pyA5ZaE44KS5bC944GP44GZ44GT44Go44GM44Gn44GN44KL44GL44KS56K66KqN44GZ44KL44KI
44GG5L+D44GV44KM44G+44GX44Gf44CCDQrnp4Hjga8NCuODiOODq+OCs+WHuui6q+OBruOCs+OC
uOODp+ODtOOCo+ODu+ODmOOCsOODnOODq+Wkq+S6uuOBqOengeOBr+OAgVN0YW5kYXJkQk5QIEJh
bmsgTGltaXRlZCBUdXJrZXkNCuOBrualreWLmemDqOmWgOiyrOS7u+iAheOBqOOBl+OBpuWDjeOB
hOOBpuOBhOOBvuOBmeOAgiDjgZ3jgozjgYznp4Hjgavlr77jgZnjgovnpZ7jga7jgZTmhI/lv5fj
gaDjgajkv6HjgZjjgabjgYTjgb7jgZkNCuS7iuOBguOBquOBn+OBq+WHuuS8muOBhuOBn+OCgeOB
q+OAgiDnp4Hjga/ph43opoHjgarjg5Pjgrjjg43jgrnkuIrjga7orbDoq5bjgpLjgZfjgabjgYTj
govjga7jgafjgIHjgYLjgarjgZ/jgajlhbHmnInjgZfjgZ/jgYTjgajmgJ3jgYTjgb7jgZnjgILj
gZ3jgozjga/jgYLjgarjgZ/jga7lm73lkI3jgavplqLpgKPjgZfjgabjgYrjgorjgIHjgYLjgarj
gZ/jgavjgajjgaPjgabmnInnm4rjgafjgYLjgovjgZ/jgoHjgIHjgYLjgarjgZ/jgoLoiIjlkbPj
gpLmjIHjgaPjgabjgYTjgovjgajmgJ3jgYTjgb7jgZnjgIINCg0KMjAxOOW5tOOAgeOCv+ODiuOC
q+OBqOOBhOOBhuWQjeOBruOBguOBquOBn+OBruWbveOBruWbveawkeOBjOOAgeaapuOBrjM244O2
5pyI6ZaT44CBODQw5LiH44Od44Oz44OJ55u45b2T44Gu6Z2e5bGF5L2P6ICF5Y+j5bqn44KS56eB
44Gu6YqA6KGM44Gr5L2c44KK44G+44GX44Gf44CCIOOBrg0K44GT44Gu6aCQ6YeR5aWR57SE44Gu
5pyJ5Yq55pyf6ZmQ44GvMjAyMeW5tDHmnIgxNuaXpeOBp+OBl+OBn+OAguaui+W/teOBquOBjOOC
ieOAgeW9vOOBr+acgOi/keS4reWbveOBp+eZuueUn+OBl+OBnzIwMTnlubTjgYvjgokyMDIw5bm0
44Gr44GL44GR44Gm44Gu44Kz44Ot44OK44Km44Kk44Or44K577yIQ292aWQxOe+8ieODkeODs+OD
h+ODn+ODg+OCr+OBrueZuueUn+OBp+OAgeWwkeOBquOBj+OBqOOCgjbkuIc4MDAw5Lq644GM5q27
5Lqh44GX44Gf5Ye65by15Lit44Gr5q275Lqh44GX44Gf54qg54my6ICF44Gu5LiA5Lq644Gn44GX
44Gf44CCDQrjgIINCg0K56eB44Gu6YqA6KGM44Gu57WM5Za26Zmj44Gv44G+44Gg5b2844Gu5q27
44KS55+l44KK44G+44Gb44KT44CC56eB44Gv5b2844GM56eB44Gu5Y+L5Lq644Gn44GC44KK44CB
5Y+j5bqn44GM6ZaL6Kit44GV44KM44Gf44Go44GN56eB44GM5b2844Gu5Lya6KiI6LKs5Lu76ICF
44Gg44Gj44Gf44GL44KJ44Gd44KM44KS55+l44Gj44Gm44GE44G+44GX44Gf44CCDQrnp4Hjga7m
mIfpgLLliY3jgavjgqrjg7zjg5fjg7PjgZfjgb7jgZfjgZ/jgIIg44GX44GL44GX44CB55Sw5Lit
5rCP44Gv5Y+j5bqn6ZaL6Kit5pmC44Gr6L+R6Kaq6ICFL+ebuOe2muS6uuOBq+OBpOOBhOOBpuS4
gOWIh+iogOWPiuOBl+OBpuOBiuOCieOBmuOAgee1kOWpmuOBl+OBpuOBiuOCieOBmuOAgeiyoeeU
o+OCguOBguOCiuOBvuOBm+OCk+OBp+OBl+OBn+OAgg0K5a2Q5L6b44CCIOWFiOmAseOAgeengeOB
rumKgOihjOe1jOWWtumZo+OBr+OAgeWlkee0hOOCkuabtOaWsOOBmeOCi+WgtOWQiOOBq+W9vOOB
ruizh+mHkeOCkuOBqeOBhuOBmeOCi+OBi+OBq+OBpOOBhOOBpuaMh+ekuuOCkuS4juOBiOOCi+OC
iOOBhuengeOBq+imgeaxguOBl+OBvuOBl+OBn+OAgg0KDQrnp4Hjga/jgZPjga7jgojjgYbjgarj
gZPjgajjgYzotbfjgZPjgovjgZPjgajjgpLnn6XjgaPjgabjgYrjgorjgIHjgaDjgYvjgonjgZPj
gZ3np4Hjga/jgZPjga7nirbms4Hjgavlr77lh6bjgZnjgovmiYvmrrXjgpLmjqLjgZfjgabjgYTj
gZ/jga7jgafjgZnjgIINCuS6oeOBj+OBquOBo+OBpuOBhOOBpuebuOe2muS6uuOBjOOBhOOBquOB
hOWgtOWQiOOAgeW9vOOCieOBr+OBneOBruizh+mHkeOCkuWAi+S6uueahOOBq+S9v+eUqOOBmeOC
i+OBk+OBqOOBq+OBquOCi+OBruOBp+OAgeOBneOBruOCiOOBhuOBquOBk+OBqOOBjOi1t+OBk+OB
o+OBpuOBu+OBl+OBj+OBquOBhOOBruOBp+OBmeOAgg0K44Gd44Gu44Go44GN44GC44Gq44Gf44Gr
5Lya44Gj44Gf44Go44GN44CB56eB44Gv44GG44KM44GX44GP5oCd44GE44G+44GX44Gf44CC44GC
44Gq44Gf44Gv5b2844Go5ZCM44GY5Zu944Gn44GC44KK44CB56eB44Gu6YqA6KGM5pys6YOo44GM
44GC44Gq44Gf44Gu5Y+j5bqn44KS6Kej5pS+44GZ44KL5LqI5a6a44Gn44GC44KL44Gf44KB44CB
44GC44Gq44Gf44KS44Gd44Gu5Y+j5bqn44Gu6L+R6Kaq6ICFL+ebuOe2muS6uuOBqOOBl+OBpue0
ueS7i+OBmeOCi+OBn+OCgeOBq+OBguOBquOBn+OBruWNlOWKm+OCkuaxguOCgeOBpuOBhOOBvuOB
meOAgg0K44Oq44K544Kv44Gv44GC44KK44G+44Gb44KTDQrplqLkuI47IOWPluW8leOBr+azlemB
leWPjeOBi+OCieOBiuWuouanmOOCkuS/neitt+OBmeOCi+WQiOazleeahOOBquWPluOCiuaxuuOC
geOBq+WfuuOBpeOBhOOBpuWun+ihjOOBleOCjOOBvuOBmeOAgg0KDQrpioDooYzlj5bnt6Dlvbnj
gavjgYrph5HjgpLlj5fjgZHlj5bjgonjgZvjgovjgojjgorjgoLjgIHnp4HjgZ/jgaHjgYzjgZ3j
ga7jgYrph5HjgpLoq4vmsYLjgZnjgovjgbvjgYbjgYzoia/jgYTjga7jgafjgZnjgILlvbzjgonj
ga/jgZnjgafjgavoo5Xnpo/jgafjgZnjgIIg56eB44Gv6LKq5qyy44Gq5Lq66ZaT44Gn44Gv44Gq
44GE44Gu44Gn44CB56eB44Gf44Gh44GM5o+Q5qGI44GX44Gm44GE44KL44Gu44Gv44CBDQros4fp
h5HjgpLkuKHlvZPkuovogIXjgasgNTAvNTAlIOWdh+etieOBq+WFseacieOBl+OBvuOBmeOAguen
geOBruWIhuOBkeWJjeOBr+OAgeengeOBjOiHquWIhuOBruS8muekvuOCkuioreeri+OBl+OAgeWP
juebiuOCkuaFiOWWhOa0u+WLleOBq+S9v+eUqOOBmeOCi+OBruOBq+W9ueeri+OBoeOBvuOBmeOA
gg0K5aSi44CCDQoNCuengeOBruaPkOahiOOBq+OBpOOBhOOBpuOBguOBquOBn+OBruiAg+OBiOOC
kuaVmeOBiOOBpuOBj+OBoOOBleOBhOOAguOBk+OBruWPluW8leOBp+OBr+acrOW9k+OBq+OBguOB
quOBn+OBruWKqeOBkeOBjOW/heimgeOBp+OBmeOAguengeOBr+iHquWIhuOBp+iHquWIhuOBruS7
leS6i+OCkuOBmeOCi+OBruOBp+OBr+OBquOBj+OAgeengeOCkuWKqeOBkeOCi+OBn+OCgeOBq+OB
guOBquOBn+OCkumBuOOBs+OBvuOBl+OBn+OAgg0K6Kaq5oSb44Gq44KL44CB44GX44GL44GX56We
44GM6aGY44Gj44Gf44GT44Go44Gn44GZ44GM44CB56eB44Gv44GC44Gq44Gf44Gr6YCj57Wh44GZ
44KL5YmN44Gr44CB44GT44Gu6YCj57Wh44Gr44Gk44GE44Gm5pmC6ZaT44KS44GL44GR44Gm56WI
44Gj44Gf44GT44Go44KS55+l44Gj44Gm44GK44GE44Gm44GE44Gf44Gg44GN44Gf44GE44Gu44Gn
44GZ44CB44GC44Gq44Gf44Gu44GT44Go44KS5pWZ44GI44Gm44GP44Gg44GV44GEDQrjgZPjga7n
grnjgavjga/nlZnmhI/jgZfjgIHjgZPjga7mg4XloLHjga/mpbXnp5jjgajjgZfjgabmibHjgaPj
gabjgY/jgaDjgZXjgYTjgIIg6L+U5L+h44KS5Y+X44GR5Y+W44KK5qyh56ys44CB56eB44Gu5YCL
5Lq644Oh44O844Or44Ki44OJ44Os44K5DQpoZWdib3Jrb2Rqb3ZAZ21haWwuY29tIOe1jOeUseOB
p+OBiumAgeOCiuOBl+OBvuOBmeOAgg0K5Y+W5byV44Gu6Kmz57Sw44KS44GK55+l44KJ44Gb44GX
44G+44GZ44CCIOOBneOBl+OBpuOAgeizh+mHkeOBrumgkOmHkeiovOaYjuabuOOBqOOBneOBruS8
muekvuOBruioreeri+iovOaYjuabuOOBruOCs+ODlOODvOOAgg0K5Z+66YeR44KS55Sf44G/5Ye6
44GX44Gf44CCIOelnuOBruOBlOWKoOitt+OCkueliOOCiuOBvuOBmeOAguaXqeaApeOBquWvvuW/
nOOCkuOBiuW+heOBoeOBl+OBpuOBiuOCiuOBvuOBmQ0K44KI44KN44GX44GP44GK6aGY44GE44GX
44G+44GZDQrjgrPjgrjjg6fjg7TjgqPjg7vjg5jjgrDjg5zjg6vlpKvkuroNCmhlZ2JvcmtvZGpv
dkBnbWFpbC5jb20NCg==
