Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF378EB62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbjHaLIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjHaLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:08:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2059.outbound.protection.outlook.com [40.92.75.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0418CE4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiBR52ugxmpOxooz5kGvUuCFC/am0Ipa4UgwqbobfiQoH3RXoOM92ezZyA9ZI1q8uQkX4N3vmxjOIqVnWhp+6fJaTobE3L+Np8XU7wKUEYpecWDq0LEa2fDUx9QseE2GLCYbi9Q6ZyoMy7ml6NkxH0TTvidJYsh2ObreQM9k0LM6l6e65eHy+dJNs13DTUHXr75dOYU0hGGIiru3X3LQtHtdBU5mdr1V65SHA6rq6mDvbxDUvhub9EN9ZRq8Ba9gcG+UtURRkjuUJnaiY8esim/fMK9g1PCptoSga8nYUDWf8Ru5JDhy/ncO23h7EzS9juzAamZ7ckXooaWBPNrg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcXh1ioyK13P5BMqLZoMY/iaJ1mDY9+DO49er5ka94Y=;
 b=a+xhU6cFH/VyRsvc5jCC5dHghGUjzXkXCTZ4FFbI2c5+h97HODMRHtDlrkz4mLtU1FhL9zMFZm9EHN33G6zcC8YuqLSLM+1VQzhj8PJjrj1wINOm/HNjSnYL2DT6LUxEnNF8NG27d2t0KIbky05BYO3dTpyd3wPwUMX+n4G64hlJihllLSUOIHXAbFk/2jOg1/Z4tbYazPm1Dhgai064P8sWvT2AdjEyYoAvHme28eCXWKuSqs+el9guvSlu2IK3uVSQhw+6znJL2HKQJhwzqCGvsxNKnX1AOIJIwUvwCwZ14cYQVklQ/+0VDE+VLHXl0TpDJL08EtzmVAQtKa7OWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcXh1ioyK13P5BMqLZoMY/iaJ1mDY9+DO49er5ka94Y=;
 b=EcTKTjmMXp+RCp7afXlB4uWpTtGstkDBfCIH7nX5e537ZFbuwM7kvu+4m8LTeruQUao576+XsUkAaLNqRWcCIeuUfOW4ey/qO7qLusAnX3K2qDm57YcHBA6NLTYB0jGBzIL2xlW9fBz1iCXtN5V/E8aH9RfkdylAcl7//PkdwQbu0mfQg4KWnmO5ieCnJxPYFf6Iw2vkmBFIdEUn2l84KNN5l+lIZVsxboazL+pGBcbu/EywjmOBNMXtzN05MuJbCTcepOdfUZ9VUOzVkDSUN+82D/tCIek/A/ROPbVSg7qieLMOfdSIkSNoxWZpSmwvpw0I5DT/9/f6aNi6EdvZ8w==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 GVXP189MB2008.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:6e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Thu, 31 Aug 2023 11:08:13 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::818e:4d4e:535e:7d15]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::818e:4d4e:535e:7d15%5]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 11:08:13 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-6.5/sound/soc/codecs/rt722-sdca.c:612: some confused logic ?
Thread-Topic: linux-6.5/sound/soc/codecs/rt722-sdca.c:612: some confused logic
 ?
Thread-Index: AQHZ2/sfQ/46u/rzhEe6doZCM0Uyyg==
Date:   Thu, 31 Aug 2023 11:08:13 +0000
Message-ID: <DB6P189MB0568614C31BD33913615C4769CE5A@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [TEeDqm521qdkRa31B8k1iqVWArEl82hJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|GVXP189MB2008:EE_
x-ms-office365-filtering-correlation-id: 622c665c-7411-4855-f695-08dbaa129209
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P23sbH9bStbOjQNcCWGXThBhb53GHIYmzcP1cW5YyVy4Ag1q7nHRlO86X8g5/DkZZXMmv13NORfCiSUYE6ZeBfsTF2YlPIL+uIJfE6ukpW1l787xaV8H5ih/Q1wRhErW0JkhGnLHMT8kNwjtXwRy2t0oLuE2lKkNUht6vI0jyt0c/y7ppRzb6ydPG1FnoBugpRMSMgIlJClP/zwkhQnz4KJrRT/orqifNucy5CNhKyClL/lAnlb8Tl+Dgjs3MXTxKNMvRoy9NNaSiMTzKq2cJslHvA6t/YpsgmSn4yj/DG8h1ZNzMiH1tp6RPkgxzmmf3K8lyvViK6C4pR2eGa86r4NkB+rvdKQy3TdaDK5uiiJYWLORxFFUBu2E/nf7lBjREmxj2whe80VszxrjL3C8uvEDj8HQm/0qjaRaPVk9ElJWfeuSBiZTxPp/JI0Nv7d5/GmqvidZBMsdLVw2yWK4Zotqzm2c8hH1VeCFYwrHcpCVuPIq/gPuKA7jT9zph65DllG2TbVx/Nz6wJzMUupeDb0dxqK3g5jD5/ElbWen/76C8QoO8lNxwLa42GC3CCPG
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kmX0QhO3YIS5jJt1OtDzTu1DBoBs2Mg5Vu9WtuYubqngLOcRcUihs1Yd5K?=
 =?iso-8859-1?Q?8KdvLG3FIGzj+K9tqypG5G5d1Dj3Fq2dFV72u5SmzvHimSFrVBuOPowg58?=
 =?iso-8859-1?Q?rO1icu3Vcpzfhj/O+gcMop53Pij5q5XOHx3pofy/pLn3bjE9IbaaR51LDz?=
 =?iso-8859-1?Q?3rNdZ0ripwTNJCmc0BcS1BxPLJBwe+9BFTxhi2LL+yO6L70nWhzeSZ27ll?=
 =?iso-8859-1?Q?0plBp6R28B2v5nmEUgO1LqhXx25m/iJiOAvBGLc+eYQx6j8QJEthScFyV+?=
 =?iso-8859-1?Q?BzTxYBB3xOQNBxBMcLVtlkKcFICOTbGTUe5Iz6n+7NIPpeZIidRqE+ooFX?=
 =?iso-8859-1?Q?25y0A55KnNw7dgnv1UmpYP6KcoQUfjQML5l3RHhGdVKrD+l9XrE8EuoTTo?=
 =?iso-8859-1?Q?I8MDa807dTz2RHisMWZFY+6BTtI0XamehcDQbWzH41XJm7YKMF/IT1Nz3C?=
 =?iso-8859-1?Q?9JuSxlQzcW5dXu3S/8tExcHAXuZC2yoigU1jFsTHUkD1zgabvIpjv2YHnC?=
 =?iso-8859-1?Q?BSYgQNxlZfCmaqyc+ynmkD0fIicmOyVRwFmEAmq1vJm/hkKpBpR2ruhqFa?=
 =?iso-8859-1?Q?QIPN8iCzzIjooKy7VYQxgVBx5FDTJNzVMjLL+ev+0/Zci7ai8hbKzIGwnq?=
 =?iso-8859-1?Q?rXnfVM+2FmVuY7MV5hv4dREva9wOraCleZwRRIF8F/uGTDkZO0FiYvWE2a?=
 =?iso-8859-1?Q?e7utfPn1njkgfjjfHipAWQYxdLY92Ox1w3eLio0II7UJxijfi2440q/buf?=
 =?iso-8859-1?Q?sDGB0fNOHB214PyZFIrhbq76vVy63VFW19IwpLwRUdWVkpQg58TPAF4i9H?=
 =?iso-8859-1?Q?xnNn1VPIXRydvuj68mUDd//MTGWc1tufAYs065ITIJroicZ1ogW/GzTCty?=
 =?iso-8859-1?Q?+dAI+prox9KoO2lueSu9Qf3Pf1A5Gy+FAGTkaLU3hDIYiFcegWIjEBap6w?=
 =?iso-8859-1?Q?NNCOnoQjuIpg+RzNnCLrvx/mMCynf4UNv1EOjlpgVwlB9XTgJv2h9DOdUN?=
 =?iso-8859-1?Q?xYm/pVnjx8wWR8dkC6M7EXfPoomYSKRG/xzWOYJs7Qdd3yZcGIwGAFbDwl?=
 =?iso-8859-1?Q?JWyuFN54A+vdGCtjYMy9OtPCMaQRzyR8hrSOwnUyi+piahHuLyPLUX42oM?=
 =?iso-8859-1?Q?NH9UdyEkcz3Z+1cUwLTrHB4TDjtp6XGGodet0ji3+m3cFka4D8MOle+lxi?=
 =?iso-8859-1?Q?xq0ZBSBSuVsMGgGG/Kl3sqh+zA9cJB1BNab4vGG8ga3KXhmH7Rz52tB/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 622c665c-7411-4855-f695-08dbaa129209
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 11:08:13.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2008
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
I just ran cppcheck over the source code of linux-6.5. It said:=0A=
=0A=
linux-6.5/sound/soc/codecs/rt722-sdca.c:612:8: style: Expression is always =
true because 'else if' condition is opposite to previous condition at line =
609. [multiCondition]=0A=
=0A=
Source code is=0A=
=0A=
        if (!adc_vol_flag) /* boost gain */=0A=
            ctl =3D regvalue / boost_step;=0A=
        else { /* ADC gain */=0A=
            if (adc_vol_flag)=0A=
                ctl =3D p->max - (((vol_max - regvalue) & 0xffff) / interva=
l_offset);=0A=
            else=0A=
                ctl =3D p->max - (((0 - regvalue) & 0xffff) / interval_offs=
et);=0A=
        }=0A=
=0A=
This code might benefit from some rework.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
