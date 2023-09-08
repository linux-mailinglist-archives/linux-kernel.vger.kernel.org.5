Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAA87981BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjIHGGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjIHGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:06:40 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806F1990;
        Thu,  7 Sep 2023 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1830; q=dns/txt; s=iport;
  t=1694153196; x=1695362796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZS7aZcYobqtW4y76JQp4u5CeiM3FiukKgj3aRa07V0=;
  b=emOwAsrAniZxCH9Q1YBvuyQOaou7rOaCQKbCF+vphvyZiqL0YsE9vSAV
   Ix+YVa9jKPJZ5rcadX+G2dC7e8oZJlUwN0CAq4Ab9EN+w6gKczNcuLZfn
   7CAlXhp5rCCQpuybPbyzfgg4MySKR29rO6vFruMzXMB0uQ1Rdh5tom5K/
   g=;
X-CSE-ConnectionGUID: uqbUxVGVSO2kQ9s3+Qj7TA==
X-CSE-MsgGUID: IKmvcR+uSbyI9k5JfKJdCQ==
X-IPAS-Result: =?us-ascii?q?A0DQAgBAufpkmIsNJK1aHgEBCxIMQCWBHwuBZVJ1WyoSR?=
 =?us-ascii?q?4gdA4UtiGQDnXuBJQNWDwEBAQ0BAUQEAQGFBgKGcQIlNAkOAQICAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFaA2GBAEBAQEDE?=
 =?us-ascii?q?hUTBgEBNwELBAIBCBEEAQEBHgULMh0IAgQOBQgaglyCKwMxAwGdBAGBQAKKK?=
 =?us-ascii?q?HiBATOBAYIJAQEGBAWwFgSCUgmBR4gIAYU4hE0nG0CBTYFYgmg+gmICgWKEE?=
 =?us-ascii?q?oIuiVKCK4MWBzKCKYM0Kok4KoEICF6Baj0CDVULC12BFYEogR8CAhE5E0dxG?=
 =?us-ascii?q?wMHA4ECECsHBC8bBwYJFy0lBlEELSQJExI+BIFpgVMKgQM/EQ4RgkUiAgc2N?=
 =?us-ascii?q?hlLgmMJFQw1TnYQKwQUGIEUBGoFGhUeNxESGQ0DCHYdAhEjPAMFAwQ2ChUNC?=
 =?us-ascii?q?yEFFEMDSAZLCwMCHAUDAwSBNgUPHwIQGgYOLQMDGUUDRB1AAwttPTUUGwUEZ?=
 =?us-ascii?q?lkFoH6CSg6BI4EwgV+SLbIICieDZKE7F6lfLpcId6gcAgQCBAUCDgEBBoFjO?=
 =?us-ascii?q?oFbcBWDIlIZD44gGR+DQI95dgI5AgcLAQEDCYhuBIJWAQE?=
IronPort-PHdr: A9a23:K75xbBMvTx7Z+SfDHGQl6nfLWUAX0o4cdiYc7p4hzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgrDmgKUYAIM/lfBXJp2GqqzsbGxHxLw1wc+j4F5Tbk8Sw/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd57N68rwx3Vo31FM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:4qKcRaN8KAtkqNzvrR1pl8FynXyQoLVcMsEvi/4bfWQNrUp31TUFz
 zdMDWCCb/iKZTDxe41zb9uw90sDsJ7RyddgQHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdaphyFjmF/kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/W1nlV
 e/a+ZWFYwf0g2EsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WILRMxa/5DkaElpaQ9hzdKDjVwapSJRRjVWEY0r4f7WBm/
 PgcLnUGaQqOwrzwy7OgQe4qjcMmRCXpFNpA4Tc7k3eAVrB/GsGrr6bivbe02B88i81UFOreY
 OISaCFka1LLZBgn1lI/Uc9hwrzz3CKvG9FegHO2oLQ82SvO9wZg8enubfjbWf6GbvwAyy50o
 UqfrzimXXn2Lue3zTuD72LpheLVmy7/cJwdGaf+9fNwhlCXgGsJB3U+Tkeyq/20olCxVsgZK
 EEO/Ccq668o+ySWosLVVhm8pjuPuQQRHoQWGOwh4wbLwa3Ri+qEOoQaZiNYYuE2iuAIfhtw1
 WbYhIiqPD4wjJTAHBpx6YyohT+1PCEUK0oLaikFURYJ7rHfTGcb002nojFLTfDdszHlJd3j6
 2vR9Hlk193/meZOhvvloQ2b6965jsWRJjPZ8Dk7SY5MAulRTYqhaorABbPzsqsYdNzxorVsQ
 BE5dyW25eQKC9SGkzaABbtLF7Cy7PHDOzrZ6bKOI3XD32r3k5JAVdkPiN2bGKuPGp1UEdMOS
 BOL0T69HLcJYBOXgVZfOupd8fgCw6n6DsjCXfvJdNdIaZUZXFbZrX03PBfMhDCxyRJEfUQD1
 XGzL5zE4ZEyV/wP8dZKb7t1PUIDn3pnnjqDGfgXMTz+j+LADJJqdVv1GALeMr9mhE91iA7U6
 N1Yf9Cb0AlSVfaWX8Uk2dB7ELz+FlBiXcqeg5UOLoare1M6cEl/UKW56e16JORYc1F9y72gE
 oeVABEIkTISRBTvdG23V5yUQOi/Acki9i5qZnRE0JTB8yFLXLtDJZw3LvMfVbIm7+dki/VzS
 pE4lw+oW5yjlhyvF+whUKTA
IronPort-HdrOrdr: A9a23:f64jkKimtwDsL/Iv/Q3ok0bRtHBQX5923DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sdi9qBPnmaKc4eEqTM6ftXrdyRuVxeZZnMXfKlzbamLDH4tmpM
 VdmsdFeaDN5DRB/KHHCUyDYqgdKbq8geGVbIXlvgtQpGhRAskKgXYde2Km+w9NNXZ77PECZe
 KhD7981kCdkAMsH7+G7xc+Lo7+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pjxi88HDh/l6Wy64TtMrqy9NFCsDJoNMSMC/QhgGhY5kkc6GevRguydvfq2oCoZ
 3pmVMNLs5z43TeciWeuh32wTTt1z4o9jvL1UKYu33+usb0LQhKSfapxLgpNycx2XBQ++2U45
 g7mV5xcKAnVC8oqR6No+QgkSsaznZc70BSytL7xEYvIrf2IIUh37D3unklUKvp2EnBmd0a+C
 4ENrCH2N9GNVyddHzXpW9p3ZilWWkyBA6PRgwYttWSyCU+pgEy86I0/r1Wop47zuN3d7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUPhvAQOAl7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBG+9QTPuwMdD4IURgMyweJP7dSmYDFw+mcqppPsSRsXdRv
 aoIZpTR+TuKGP/cLw5ljEWm6MiX0X2fPdlzerTAWj+1/4jAreawtDmTA==
X-Talos-CUID: 9a23:u0ed7GAtnWvuJGn6EzR+/nMEJO8bSVqHz06BOBT7MGQ2dJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A8RMUrwyey4YKqnxh95ioWOLCSE+aqIWNDV4Gq9Y?=
 =?us-ascii?q?bgMOVFH1zZhWTrxa7abZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 06:06:35 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 38866ZAn016611
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 06:06:35 GMT
X-CSE-ConnectionGUID: MDP2nPVoSnq+rtkJrzRkrg==
X-CSE-MsgGUID: 97PGk3LySgeCxypC77UfjA==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,236,1688428800"; 
   d="scan'208";a="641723"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 06:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE8ib68aIGJTE5OMvXDpvkiEai0yq9CLFjrJv6xd7fgoOpxYzuJZoU6eNeWZO0koDw1sQqLUS97kQQ3R7f0AhdwZESe6N65JZCuK4h0GGIVHkTsvi46fSW1OZzcb9KAst4Cdz2wjb7TEwAMqTd9oyP7CZMk16GoU8p4U6X8kDTgXyGuAOKF9/5lr2UbdpSnlJ2nLqM21AY81fDoX5WzfEWJnMxPFOxDGR7pMl4s3zTTYPROU3bL0NxhCnphHu70VJyRG6mvSGyInWPM4Frp55pRsB2yiaAoF+DHeKth9TUQXwDnkT2DDmwCNprE0ipeTG9hX+L2e6mApa5vduUEpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZS7aZcYobqtW4y76JQp4u5CeiM3FiukKgj3aRa07V0=;
 b=FDqaahDyvwQRBcaPOl/GxpQnaDba+h/ilCj0YdL5OKw55cikvuaBOGGQGxa0EM2XkAdnrx6TcmTaLDhuME2zyU6seefCgrs/+EEOUwMyl/97Yktt/CR+VA0oTKCQb/uLLnhP6jxQkFrZo4GLanFD7PHFXORZiVJQrE2e5MoRQ27YSWngakeBHqWKkIqRz9HH9o7YH9ApwK7gWn8RezQytG3X4/OqSgsfS80f5aJjL+C6Kh5nXhJ13mF1o5G5X05zkAbjcVfGjrwIIQb1pU71GMZuOzj3HXabmCMmdiiBtd1oC+8Z0SjX3z3WmnMeIxzxBo3eb2ONOPueKbAOufQPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZS7aZcYobqtW4y76JQp4u5CeiM3FiukKgj3aRa07V0=;
 b=QAthoQr6R4UJzFaHZUSrPWaxQco0qj6xG1dgaNNhc5wKFjZ3O+xZFI6A/wWE6VsE9YsHSv4JiR+acf9AyvhSrNgRR/zBA3zKjM5iDehRYBBJ5IE2YrdQ99dZqyPIr/ckdKkBURsJg0/WrdLZHzetd9v+3Iu/NO1/6OReZNyyI+Y=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:06:33 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 06:06:33 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAPJ16AgAEtl9CAAB50cA==
Date:   Fri, 8 Sep 2023 06:06:32 +0000
Message-ID: <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|SA1PR11MB5924:EE_
x-ms-office365-filtering-correlation-id: e40efa9b-ab82-4af0-aa84-08dbb031c03b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwQbPJCFISiPnuFLF0E+PdkeynH92ZYpn4YF3JrKfT6d7LmKL64tEmPaEKIfy7KLUKprawu6duYKQHj70Lq5oKUbgryvklxsN5K5aQo0iF2ylsHBpfsZWdwq9cbiDXW8xwo4kUGfBFGleGeP94cirKPnJxPDdZdeiNLAqPF5a6g6OsjoaS06g/iRwwVRyLXm6hZla6GH1L2F/JkapLiGPljT4+raqGRl0fyoWutD+b7MrMSeMssPf/PbxvIf+59OVKnI6BDWs4Yq0ZzpRn44ovTUMi2fleLxXl+3LanehomJ2kINUD9NgJbJwwP1iBwzXyodw1btRR6/Af/Bfi9N/c+5P5hHwqYNw/SXvMLXNQ8xlHJp+cuFQXUgUIBTYJBNb6N8pWVqYZxMFh+Ubxy6qwU6wGlr3waI0RKRWhoEeQnYec1q+imdIIsU5x9iRKD4TMXda1MdWq7N59vb3zlPPwUMVDoD02sB4rEJuM012g8IMxJJ2sBVmR8QbmcmkDTpzR0n+CJ3JtULH7W1d5YK56lVc6KVpSZ8PYbmMpIwQqvW+qR5RC0z1WK5IToWEfIBK1xu1ebG7sIlJpUZM/zrzb2Qg2j2zGLCAt9lEBDWIYfWE6Uv5/WAIxdOOXZYNF0x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(55016003)(52536014)(83380400001)(5660300002)(2940100002)(9686003)(53546011)(41300700001)(7696005)(6506007)(66946007)(66556008)(66446008)(66476007)(76116006)(54906003)(64756008)(38070700005)(38100700002)(6916009)(71200400001)(316002)(33656002)(478600001)(86362001)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXxMcipKrQx2L+NQISy/nw0YZK8eragQVJdlY8E6tTsRkN5er0+495FxTQmD?=
 =?us-ascii?Q?cEEH8pClJ+FydwM6xBM6C/Sz0ql6XZml+1x+5nZWb1GgqzRIcQxv2bhsIWwQ?=
 =?us-ascii?Q?hg+quRen6OtHCUa5B/PJtKY7vLorQJNQ+kJFkHJeVAgjjIp8/4t0GLm+TqCq?=
 =?us-ascii?Q?Zt+/dAbFHg2Bl40TgZ+VazjwJ1VNfddxuCa/2M34JcTq5k1tV3bQkRwIBexb?=
 =?us-ascii?Q?u78Nko64MNfPiSUUA8NbSrWB0NC4R2f9H4w3o6cshlyIJuu8t1Z3ffenElU8?=
 =?us-ascii?Q?3qw+3OENs4q4RYUYwewTsGFIt0t2orSnshwnsm/2qshlOJYoGMlDs7aQfSI/?=
 =?us-ascii?Q?BLv0mSBKJHjpfSFxip40j43/0QejAC0Jj1mlUE97RHtxFuOYeSkume2rSeoc?=
 =?us-ascii?Q?fbNfLQ7G9w6UObL3ZvOBOAC1vhbFY0uZfTOrSLGFM45wYThY0hVW5ZchrK8/?=
 =?us-ascii?Q?exeAv8cpxLPLOzDuTitG3TIZ/ndoGQxjM3WjC+macWIlGkZUb1PCo8SXUtYP?=
 =?us-ascii?Q?XTVhkqtjykbZQXrK5K5GRoCUtJ2fIFCtBLEPE6IYiBpeHD++EVSFsYbpZ3Rf?=
 =?us-ascii?Q?/r+mld8yfZHil6xDjTHwB89+47cA+767TDiHzCw5mpxpK8nGit8G73d2C1BP?=
 =?us-ascii?Q?DlcKP+onLEp8PbuH8yGxVl82sYmhyJtEwucNgKJqSo48WmbQS9IxePewnenO?=
 =?us-ascii?Q?yomq4L9eLmfWpCHBFuLL7/jAC7bPxzZKjn+O/XKmyurBogmlJ+GrhUR6dQ/1?=
 =?us-ascii?Q?q+X1imndCK1VoDZWPrwHl2tgpKDRqW3WJdWHI1Tz/RAX+tA6yZfTGqU4rlOi?=
 =?us-ascii?Q?xwRHJuXvFhTXz60qCmmjIAvCPytLwiX/205lNJjN/7hFrfRLPMXpYuCYaqSD?=
 =?us-ascii?Q?rrEdpIAs1cegA0qu/iqoi0iQb0malJXNFa/BRIqv27OHq8nDPXmALrXbpH6Q?=
 =?us-ascii?Q?frHUn+9h26CTa9+M96R6QhvaFMmPGDj3OYTCWHY0LmX1UVpOJBog+nhSkTWJ?=
 =?us-ascii?Q?Eu/Bi0xZIYU5iNJj0PbogAhXf0tBHe06cLzJv5B8o2nUuowUlhBnFc/P+G4n?=
 =?us-ascii?Q?TQLzFKERuQTVCu8RjVFpTzSHebay9QYyHcUkD/UXAcZ0o4pjEF05wc1WEO56?=
 =?us-ascii?Q?dgKexQXXD1nquski3YNp+LDSN6vj3sDidyrI4+azl6xiCYKoAYXtsXskwIRO?=
 =?us-ascii?Q?TEz6R4tqT/2zx129aTFCbflI/lEcP/tHpqUGbGzwUPX7x77uGHKan1BNTC7r?=
 =?us-ascii?Q?5WfDfYId5rrlVo182YnWQ/jxcIt+/Mo8WKPiLKt88mvv3p5mtsRafwmfyf5A?=
 =?us-ascii?Q?Tx83W3A9BhDQJZX+1d0ugs7NZF8qr1cGA35iwDgLQ+3x2Ar2ZnIsu9VBhpID?=
 =?us-ascii?Q?as5LVWjbU9ZtfO3qLTEiwmF3LKItWuwxNv+6PCHFRrWFwuywj18xhOfusA6a?=
 =?us-ascii?Q?1gse6WtHxDqAEfr2pYaQpbMLKX98E5XHQz3xYEMhQ6FhghB8ebSK2vJ/Z+LJ?=
 =?us-ascii?Q?7e+2aKVAOjb0Dsh5Oc9AjKSUj1XdXeFy5bDmei8tM8a30tmoaooMi45JSryj?=
 =?us-ascii?Q?98UkVXl523fxJ2cA9aRWYszNavL/1Mkyl4SqZLeXKFwVpxs8CgdfVukPE5f6?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40efa9b-ab82-4af0-aa84-08dbb031c03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 06:06:32.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6yS1L4HvdaRDhowa3r6y65Kkb2Ggec70604Y8dMxHl3LJtXDuW8FDOuEBOh0oxoZPnq28t3NZlLQKCU20tK7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
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

I just saw that v6.1.52 is merged and released so can we consider this patc=
h for v6.1.53 for v6.1 kernel.

Thanks & Regards,
Deepak

-----Original Message-----
From: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)=20
Sent: Friday, September 8, 2023 9:48 AM
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

Hi Greg,

I want to merge this change into v6.1.52 stable kernel version.

I have added these details in my patch subject message. Sorry for inconveni=
ence.

Thanks & Regards,
Deepak
-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>
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
