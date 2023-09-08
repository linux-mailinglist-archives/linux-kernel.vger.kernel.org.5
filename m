Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8D79812E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjIHETQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjIHETP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:19:15 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 21:19:11 PDT
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192BE1BDD;
        Thu,  7 Sep 2023 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1327; q=dns/txt; s=iport;
  t=1694146751; x=1695356351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZL/w0ZvtsBW4aktza0zG8SBJhsEb4vxukVV7hDhj9Hw=;
  b=KcmuwKB8a6oNjZ0e8axtOG9pHg4lTKQcpolarOe05iIiKcB0bhuGXNpi
   DM8hGMfe53SBOem1916WUQSduYLmcOeHquw73TR4DgJtoLG/xEe8Z5p/a
   UirwQWwKmEpUygfHJWt+VEI6aBsyR5DPkvbAPqx2tHtYcHximAygqyCPL
   c=;
X-CSE-ConnectionGUID: oOXD9SKyQAWf7I36bRyqrw==
X-CSE-MsgGUID: pDD/ZNdbRhuCGIevMQouMw==
X-IPAS-Result: =?us-ascii?q?A0DQAgDpnvpkmIoNJK1aHgEBCxIMQCWBHwuBZVJ1WyoSR?=
 =?us-ascii?q?4gdA4UtiGQDnXuBJQNWDwEBAQ0BAUQEAQGFBgKGcQIlNAkOAQICAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFaA2GBAEBAQEDE?=
 =?us-ascii?q?hUTBgEBNwELBAIBCBEEAQEBHQEFCzIdCAIEDgUIGoJcgisDMQMBnSQBgUACi?=
 =?us-ascii?q?ih4gQEzgQGCCQEBBgQFsBYEglIJgUeICAGFOIRNJxtAgU2BWIJoPoJiAoFih?=
 =?us-ascii?q?BKCLolSgiuDFgcygimDNCqJOCqBCAhegWo9Ag1VCwtdgRWBKIEfAgIRORNHc?=
 =?us-ascii?q?RsDBwOBAhArBwQvGwcGCRctJQZRBC0kCRMSPgSBaYFTCoEDPxEOEYJFIgIHN?=
 =?us-ascii?q?jYZS4JjCRUMNU52ECsEFBiBFARqBRoVHjcREhkNAwh2HQIRIzwDBQMENgoVD?=
 =?us-ascii?q?QshBRRDA0gGSwsDAhwFAwMEgTYFDx8CEBoGDi0DAxlFA0QdQAMLbT01FBsFB?=
 =?us-ascii?q?GZZBaB+gkoOgSOBMIFfki2yCAong2ShOxepXy6XCHeoHAIEAgQFAg4BAQaBY?=
 =?us-ascii?q?zqBW3AVgyJSGQ+OIBkfg0CPeXYCOQIHCwEBAwmIbgSCVgEB?=
IronPort-PHdr: A9a23:jkQDBBTY3RrZUazzYczU7eqQKdpso3PLVj580XJvo7tKdqLm+IztI
 wmCo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk0GUN3maQjqq2appSUXBg25MAN0IurvHYuHg8m6zemu+5r7aARTjz37arR3f
 126qAzLvZwOiJB5YuYpnwLUq2FBffhXw24gKVOIyhD74MrxtJI2+CVLsPVn/MlFOZg=
IronPort-Data: A9a23:e4HWqqDEBAF6ihVW/+Xjw5YqxClBgxIJ4kV8jS/XYbTApDhz1GEHx
 jAXCGGBO62CNzTze4twOo+28x4A7ZbTmoM1OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGdIZsCCaE+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357hWWthh
 fuo+5eEYA79hGYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxMUlaENQ4ZW7
 86apF2I1juxEyUFU7tJoZ6nGqE+eYM+CCDV4pZgtwdOtTAZzsA6+v5T2PPx8i67gR3R9zx64
 I0lWZBd1W7FM4WU8NnxXSW0HAl5Gp1qqYTkMEGWjsLM7haYeUH92u9xWRRe0Y0woo6bAElH8
 fgebTsKdB3G2qS9wamwTa9ngcFLwMvDZdxE/Co+i2iCS699EfgvQI2SjTNc9Ds9i9pHAfbZT
 8EYcjFoKh/HZnWjP39OVctvxbz41yiXnztwsH654pgR72LpzBFa/5ngLv/sfcGvWpAA9qqfj
 juWozumav0AD/SbyDyY4jevi/XJkCfTRo0fDvu7++RsjVnVwXYcYDUNSVKxpfSRlEGzQZRcJ
 lYS9y5oqrI9nHFHVfH0Wxm+5XWDpBNZBpxbEvYx70eGza+8Dxul6nYsSRlxRI0dl94PbAMki
 X7SwdnTFCV1r+jAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqlu0Xojqf4+TsaIYs3J9SLYm
 GvS/XJu71kHpYtaifvnoAyvbyeE+8Chc+Ij2unAsotJBCtQYIqoYeREAnCEsK4Ydu51orR91
 UXoduCX6OQISJqKjiHIHaMGHaqi4LCONzi0bb9T83sJqW7FF52LJN84DNRCyKFBbp1sldjBO
 x67hO+pzMUPVEZGlIcuC25LN+wkzLL7CfPuXe3OY9xFb/BZLVHWoHg3PBLLjzy0yiDAdJ3T3
 7/FK65A6l5EUcxaIMaeG4/xLJdynHllnDOPLXwF5035ieT2iIGppUctaQvSMb9RAFKsqwTO+
 NEXLNqR1xhaS4XDjtr/r+YuwaQxBSFjX/je8pUPHsbae1YOMD96UZf5n+h+E7GJaowIzI8kC
 FnnBB8BoLc+7FWaQTi3hodLM+OxB8Yk9y1mYETB/z+AghAeXGpm149GH7Mfdrg8/+slxvlxJ
 8Tpse3ZahiTYlwrIwggUKQ=
IronPort-HdrOrdr: A9a23:G37LRak/ND/68wRvPmLU17nJS6/pDfNpiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOCUghrZEGgE1/qt/9SAIVywygc579
 YDT0EQMqyMMbEXt7ec3OD8Kadf/DDlytHouQ699QYQcegCUcgJhGkJb3f+LqQ1fng4OXNTLu
 vl2iMznUvbRZ1hVLXBOpBqZZmkm/T70LjdTVotARkh5AOSjTWuxoLbPnGjtCs2Yndk+5tn1X
 LKvTDYy8yY3s1TzCWy60bjq7Bt3PfxwNpKA8KBzuIPLC/3twqubIN9H5WfoTEcuoiUmRUXue
 iJhy1lE9V46nvXcG3wiwDqwRPc3DEn7GKn4UOEgEHkvdfySFsBeoh8bMNiA17kAngbzZZBOZ
 FwriSkXl1sfEr9dRHGlpz1vtdR5xKJSDQZ4LUuZjdkIPgjgfdq3P4iFQVuYdc99OaQ0vF7LA
 GoZ/usvsp+YBeUaWvUsXJox8HpVnMvHg2eSkxHocCN1SNK9UoJhXfw6fZv1kvozqhNAKVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOVfUki956Lf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCG2XCjryMtZ+59l04eMCYbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7v5IW7nCe9yrkTDsllpWA8jueEuy6EGsgi107f2w6XRx5jmTMo=
X-Talos-CUID: 9a23:hYKwvGG8DJumufBRqmJg0344S/sGY0T083mPAhTmA1x4UaeKHAo=
X-Talos-MUID: 9a23:2L29pgse3SVK0Y7+rc2nnB1Oc/VO766UCF0mvrQLpey9MjFVJGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 04:18:09 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3884I8Ue017675
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 04:18:08 GMT
X-CSE-ConnectionGUID: 6jGiuZU1QxalPlkEiX9uzA==
X-CSE-MsgGUID: SCV6HzCMTS+r11jUJT7+DA==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,236,1688428800"; 
   d="scan'208";a="633585"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 04:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbrphReiTAgWQhHcSUtFYqjvghPZ6IZpn1QNUsZDF9Q/ff0WGCjB6mRGJ7SeUklTkOXNaWWI2vIm+9+rXdpeiOO7qQBEl9EsqbnqmU+GL4C8pkMFPZOJea0GhjpyIACfdGKeakMo4y6EZ8ihnMtthZqYuHs5y/HS1bQ6xeutnXtm+v5bTT4g7MKA8LgIYv8Ipgb/SuO8p4AK8hQA9je3KAh5QYyuqo/WgSAV4+tu0RGZeDBaoZki6RRghpF/IHJJew48Ty3d4G7u9igf3psWkL4I3PJh4M0iSDs6Im16WyWyt2dgv7MNDDc3Dcdfn+oqws5ylp5nu9hW40zbEi++vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL/w0ZvtsBW4aktza0zG8SBJhsEb4vxukVV7hDhj9Hw=;
 b=Q5Bwms9maBcpfweGC+3iqi6HQXihvWpO4ybIRuWIrliUS7Oo6IAWbOLns5cBKZf1vDN77Aa+QI4COSap9KaM8QDD2EBoOq0ZJOo6hFQm1RfVEaqh9PLrYWKCNx0WgrmjKV1Q/qoYXUR9iHfWXywC2wQPBR9LRKgfq6CWLoUOax3xty7fJxvaetFexMYAA6TAObJfmC42k183lcCcWIbHzuNnPMmb6/CmBCBLgs9GUBwQyoFBjDjdQzeR12Mi/PB01yayuct9pqOOmyh2rmDbpI8ItoYkNq4Wrb2rb0yM2vUx2z9QOLx39PfFOVBuj1wk1+Noms3IS2/9VptktSQpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL/w0ZvtsBW4aktza0zG8SBJhsEb4vxukVV7hDhj9Hw=;
 b=O70dZBnTUmvGrLSXs8BFcD7hwOHVG8MhzvU/r+gdg3hcLVLySliCnlt0a1yaNXD/nocZLCKBa6w7ajDZV4WdmWGR/Gyyjs2yRCgn9yzIo6CV0q3oqOZtHnmXzLVgrHFniFsRIw4L0LHRQdXOgYDizb92IWpa5vbena5soEHIX/Y=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 04:18:07 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 04:18:07 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAPJ16AgAEtl9A=
Date:   Fri, 8 Sep 2023 04:18:07 +0000
Message-ID: <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
In-Reply-To: <2023090738-passive-snowless-3b9d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|SN7PR11MB6800:EE_
x-ms-office365-filtering-correlation-id: bb0d206a-2745-44a8-9fb2-08dbb0229a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 187xFZ9qkX8CyAEZJ38+m1XQwFRJS3L8/+ZH/VK5umgYCHEO5MPclBRqNqlU66X7CXETm0q8R1uN8zTkxq7qiKPoe5duRBAmsixyW7QLkrqIlmOzOqPciwqmgadKqqZGf3am7ZlLvbd6Mq+3coQ3hYwY9x68VTgUs7WE9Eh4l0Li+3MPKyMhxJVvGps7urQh73MAjQvsvJS/SBsTxo62LA6mnWwsoPhhy8Dr3+17LNu96bTWiNnIbGk6anmF+DhUMqvB/W9gCtyIGpIi721hpaDuoZdGcFXnOnFWrsf00wBfkWPvNmBpnDLVJKm1oqIEYKQ936aR7Fsm2daJLmDNAGadUEGHVYxJo1luJb0MNxNuI8OJlAoL5OT4k21ncBFiiY3GbsXDncD0GEHTn3tLlbNhiFhat9xvhF32pV51YJTQWOgCue8BwxN3WR+uHhvOfaQv97F15WIop4mh5+ZSuhFspAGLd/vwYduTfeYfelpz+m672vvhOdNUVx7LD/huB3jpeHzWNi4VRRFBP0/NXBY3+maqdB/YnY3FekOYjr+QfURIDzBjHfCvPV5c0Fb5SxvqXlAI7s8s09fT/Ak7pw/bVGFV8Vh3zFPa0ogSMQKn/uVYb83IoJhCM20CroNb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(186009)(1800799009)(451199024)(52536014)(53546011)(7696005)(9686003)(6506007)(71200400001)(86362001)(4326008)(122000001)(55016003)(33656002)(38100700002)(38070700005)(2906002)(83380400001)(478600001)(66476007)(41300700001)(5660300002)(76116006)(8936002)(64756008)(8676002)(316002)(66446008)(6916009)(66556008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiP9sceT3334l7KjIqt4+YjeCypYpZEPa4oudQL5TwtKkACJeWotPJhSyDbs?=
 =?us-ascii?Q?UQgExX7fxFVkcmHpOSRaok+YQ9zw+3bTBAOl3FiHEEIOl3fL7UbLlJX7uke5?=
 =?us-ascii?Q?ywJTOcwZHiHUAeaDgLGdwCrKCEWH/URPgu/A3NDkvFUo+HY9XGQVmw8QPlvQ?=
 =?us-ascii?Q?tHztwWEA8s/Pk8/UhSEFYEhumNYQLDPEcdkrtz9NvBw/f+YjzhvngTwMPj6i?=
 =?us-ascii?Q?BrkU6BY7P+lgp/ngdJeX4WEwbIB4aYIumf6Wwn5/wBpG28GgTCi2+RDuiKKe?=
 =?us-ascii?Q?NwS2jkopEFzxoej+y+sYzI/IGLYNnW7EPEjNjgdnQwwT2NBfNSOFNt/1hTH3?=
 =?us-ascii?Q?+pkqLw6yhdByAxeIgo3YwvkKcESvV0sRiBglcquJ213g7G9OSnH9c8UFByzA?=
 =?us-ascii?Q?v1a8VeGoFqT6ZtFmDvRId7pYV85UITQsjrgqYmvLbRqMvAZ7FRr+O5vxvbAs?=
 =?us-ascii?Q?+rcP7wYRrq44v7HGIZqKuPf1BPFc1EVI6W64xm5H0qPDvImXIEoXq0fDvuJk?=
 =?us-ascii?Q?gl1pO3F+XEA/fC/sAuFc5kdfL9MvIuUQrIldye9ekU5AohzZ1Pp5rGxzK5bg?=
 =?us-ascii?Q?42gCwf1TbXElXS4vl097m8lDMn1I/QzGAlAS0x/ilMemRQJulXETBU9j2OJH?=
 =?us-ascii?Q?Rw15V2J1zhL0+kzJCZs26Wds06XaCoyn8fLtm5lTqJ5iAvC03lrrqEi+mhQr?=
 =?us-ascii?Q?/yc4hUj7BJQ33TmCmDAJ5oGpeA8z8BWoAjAerFshxvfFPwBrEq2j+5R3Pcyf?=
 =?us-ascii?Q?PK4Xi1tl6lJGY19MrxZFY8cv7+gSXKE1gSEDAfollhlLsAWXkKuUw/QdoiDZ?=
 =?us-ascii?Q?83nrALpFlEcJOel7hJUhAWd7q1sQhHZMwT00jp/AlXOiVon0ATnLXC6IO9yu?=
 =?us-ascii?Q?UX4JaLtlFVgrhTkk6ZSyGGX0HqAdg9J/24QNJhi94R8LQNII01JA8/7F1GDM?=
 =?us-ascii?Q?dMoF4/duLWib2e963gYk4qbQarzFluQQAVpLb7MN0eEA3ZpKMRCG4pl+JAXw?=
 =?us-ascii?Q?Mo2gRSD1x1Sx37CPKe9qQiBuTYKwvn2Uxt5gqw9V3VjoY7z/zwCiX4GSRTP2?=
 =?us-ascii?Q?/vVasp4aWiPZlLV/r+bGaA3FCVNvU2hC8gGLolLUOkPA16IDYa2ifp/dSuUa?=
 =?us-ascii?Q?/B3m42wZujnYgknBjFiWoUv0WhyiQVY1/EE3QnNvTDePoqaZZrxR+g4ALtOy?=
 =?us-ascii?Q?si4UErPUNprciHTHUJUKgvbejYWp9Xf7J1GUHrh3W6K3vzmym6zIbmNvW9ji?=
 =?us-ascii?Q?gbteAkkjvZ6myhtHV7SEfUIAYMtE1qzR42CCVzfdoBO495b4Se14v+Y5Xve1?=
 =?us-ascii?Q?/+YFpNVUy0S1bAPpkp3nn86Sic3ObmyLIKl6wjroukmd14LevqzdGz6KY2nz?=
 =?us-ascii?Q?8nToNYbHElTo4IGXOKaHdWGShcF+QOflKXmY/yCpRyEWiFq4oNjtEF8q+wFO?=
 =?us-ascii?Q?PqzT4y+qpwo8NnG94vlP5zZVz6Lbq5Dh1RusviYvYfPNGa4Km5AhKY0djeFv?=
 =?us-ascii?Q?zgq//e9LlBQtoTmDwzBfo7+1fVK+PHElPaAI9Mfs3000m7b9PJtdZ2lRLC8u?=
 =?us-ascii?Q?qFYCxmfuCclr2tVijLZXbAG1XJzv7HOA41VlvQlrCHZ6BMGIozaEjZaUBAGC?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0d206a-2745-44a8-9fb2-08dbb0229a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 04:18:07.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HP6f+P76N6cY+TT3FFzQdgDwFZrW764dgp/GSH1Om1LWZgZzTLgcrgEyajc4/z9M4tOxtehEY+ZuVtq7RRpCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I want to merge this change into v6.1.52 stable kernel version.

I have added these details in my patch subject message. Sorry for inconveni=
ence.

Thanks & Regards,
Deepak
-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Thursday, September 7, 2023 3:47 PM
To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisc=
o.com>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

On Wed, Sep 06, 2023 at 05:45:25PM +0530, Deepak Rathore wrote:
> From: Zheng Wang <zyytlz.wz@163.com>
>=20
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
>=20
> In btsdio_probe, the data->work is bound with btsdio_work. It will be=20
> started in btsdio_send_frame.
>=20
> If the btsdio_remove runs with a unfinished work, there may be a race=20
> condition that hdev is freed but used in btsdio_work. Fix it by=20
> canceling the work before do cleanup in btsdio_remove.
>=20
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>
>=20

What tree(s) are you wanting this applied to?

thanks,

greg k-h
