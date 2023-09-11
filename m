Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE44179C039
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379075AbjIKWlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbjIKO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:59:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28FBE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:59:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9a9d6b98845so1093926866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444379; x=1695049179; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKApCngIKzzN4p4JDS7XDvOV4woJwfi6+W63xLlsjfI=;
        b=jsxlgMtxP16WMKmi/LJO/DnBeokp2iZrbcoaeZPLUSv1zRSkOo+OJ2EBOgMZijgaf6
         wbZI1mTnJ/nOrhMEYMPia0FBL+tj3aN9HKtoRxFf1rvhcoA/6LZy2f5DD6/gjtP7KFor
         8Nrb9NfLgAu4LngD+Mp8FiOt4no1tAQrWNjDrlnkqDFSfAY2DnsVYwhxvuWZo79lJr1w
         TDExzQMJ7WZRoqdagE/EzwMrXZ2YfdMYQB7Ns3thVbrh1/b3QFLO95y2eLYQVE0aXneZ
         xZr638UfP69GHIJOgwoheT5UBfD7tqx3k7ADAL7KazZAAVJqiihM3CTIfy4R/S5ynm/N
         M10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444379; x=1695049179;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKApCngIKzzN4p4JDS7XDvOV4woJwfi6+W63xLlsjfI=;
        b=c9IVWq/2G78iwFIMeRbhdXd/5TJvjA6zOeMk81Gn2WjzYpOqRDlLKNJqLVSkw23m5Y
         MX73Qx6L3JTIrjpq8tZOqa6j/GXJGlg6KDKffFO5iTIEva2mxY/CTGFw2t5Sx3LGxxva
         FViJIuZmVlyo/nX4V2pxIsEOXNQqeuY5aG5VXiCkuhI/NdZKGvuKsachVO3xPmNWZoEo
         Bfti0Si4hh0U6YXxcsBHY7G9LyAnKLWs6rmBwo9iwM0vxfXxRPodMcxIi8HyJCWh7mg1
         5m2Q7UydEMgr/40mCAtxuMcq+XiPy07z30TFFsUh46LaCoFM0Q7MbBgC14tofs/rmoI1
         4cUw==
X-Gm-Message-State: AOJu0YyogPMoksrHZW6BjypN8oBjJ1T5UmzJZILcsYcSKNueDpxeQFeF
        bghahLMYtJuXBhE4sbXwSDcKByhgJk3BfbyjNiI=
X-Google-Smtp-Source: AGHT+IE9HCb0aI/uoUlgYM3Y8AWvscoCkcRFln5phc4MDU1g/ol2AEEtiWt+NSobCMIYDU/yzNXouT5vfB3/mIH+zdg=
X-Received: by 2002:a17:907:7758:b0:9a9:e858:e731 with SMTP id
 kx24-20020a170907775800b009a9e858e731mr14795496ejc.24.1694444379091; Mon, 11
 Sep 2023 07:59:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:2a89:b0:1cd:4a4f:77b5 with HTTP; Mon, 11 Sep 2023
 07:59:38 -0700 (PDT)
Reply-To: laurabr8@outlook.com
From:   Laura McBrown <atmcarddepartmentbtci.tg@gmail.com>
Date:   Mon, 11 Sep 2023 15:59:38 +0100
Message-ID: <CACLRigZwsprgF-Qjas3e5B1iEj481xO9DuiK47phpM=TJZjJgg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pozdravy tob=C4=9B

S n=C3=A1le=C5=BEitou =C3=BActou a lidskost=C3=AD jsem byl nucen v=C3=A1m n=
apsat z
humanit=C3=A1rn=C3=ADch d=C5=AFvod=C5=AF. Jmenuji se pan=C3=AD Laura McBrow=
n. Narodil jsem se v
Baltimoru, Maryland. Jsem vdan=C3=A1 za pana Walter McBrown, =C5=99editele
spole=C4=8Dnosti J.C. Byli jsme man=C5=BEel=C3=A9 36 let bez d=C3=ADt=C4=9B=
te. Zem=C5=99el po
operaci srde=C4=8Dn=C3=ADch tepen.

A ned=C3=A1vno mi m=C5=AFj doktor =C5=99ekl, =C5=BEe p=C5=99=C3=AD=C5=A1t=
=C3=ADch =C5=A1est m=C4=9Bs=C3=ADc=C5=AF nevydr=C5=BE=C3=ADm kv=C5=AFli
m=C3=A9mu probl=C3=A9mu s rakovinou (rakovina jater a mrtvice). Ne=C5=BE m=
=C5=AFj man=C5=BEel
loni zem=C5=99el, ulo=C5=BEil zde v bance =C4=8D=C3=A1stku 2,8 milionu dola=
r=C5=AF. V sou=C4=8Dasn=C3=A9
dob=C4=9B jsou tyto pen=C3=ADze st=C3=A1le v bance. Pot=C3=A9, co jsem znal=
 sv=C5=AFj stav,
rozhodl jsem se darovat tento fond ka=C5=BEd=C3=A9mu dobr=C3=A9mu bratrovi =
nebo
sest=C5=99e, kte=C5=99=C3=AD se boj=C3=AD Boha, kte=C5=99=C3=AD budou tento=
 fond pou=C5=BE=C3=ADvat zp=C5=AFsobem,
kter=C3=BD zde budu instruovat.

 Chci n=C4=9Bkoho, kdo pou=C5=BEije tento fond podle p=C5=99=C3=A1n=C3=AD m=
=C3=A9ho zesnul=C3=A9ho
man=C5=BEela na bezmocn=C3=A9 privilegovan=C3=A9 lidi, sirot=C4=8Dince, vdo=
vy a na =C5=A1=C3=AD=C5=99en=C3=AD
slova Bo=C5=BE=C3=ADho. U=C4=8Dinil jsem toto rozhodnut=C3=AD, proto=C5=BEe=
 nem=C3=A1m =C5=BE=C3=A1dn=C3=A9 d=C3=ADt=C4=9B,
kter=C3=A9 by zd=C4=9Bdilo tento fond, a nechci pry=C4=8D, kde budou tyto p=
en=C3=ADze
pou=C5=BEity bezbo=C5=BEn=C3=BDm zp=C5=AFsobem. To je d=C5=AFvod, pro=C4=8D=
 jsem se rozhodl p=C5=99edat
v=C3=A1m tento fond.

 Neboj=C3=ADm se smrti, proto v=C3=ADm, kam jdu. Chci, abyste na m=C4=9B v=
=C5=BEdy
pamatovali ve sv=C3=BDch ka=C5=BEdodenn=C3=ADch modlitb=C3=A1ch kv=C5=AFli =
m=C3=A9 nadch=C3=A1zej=C3=ADc=C3=AD
operaci rakoviny. Odepi=C5=A1te co nejd=C5=99=C3=ADve, jak=C3=A9koli zpo=C5=
=BEd=C4=9Bn=C3=AD ve va=C5=A1=C3=AD
odpov=C4=9Bdi mi poskytne prostor pro z=C3=ADsk=C3=A1n=C3=AD dal=C5=A1=C3=
=AD osoby pro stejn=C3=BD =C3=BA=C4=8Del.
B=C5=AFh v=C3=A1m =C5=BEehnej, kdy=C5=BE naslouch=C3=A1te hlasu uva=C5=BEov=
=C3=A1n=C3=AD,

pan=C3=AD Laura McBrown
