Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23277F2568
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjKUFlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:40:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE24A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:40:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43j8T001153;
        Tue, 21 Nov 2023 05:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ytQOJTFfnC0yeIKVZ9M2KR3Rxj00QSeKnZtrv3aXzYw=;
 b=DdPvSX1zgYe4J3NMlRPrDhYtwg/rnE3LSN2M4F3dt6++nru6Wyb+z8qX8N/SHF8uXILW
 KWRTELrYuvStjD138o13Kax6zD6RvR2sq8kMCJ8hSjLUTndhgDwrRsKMS4oL3tKAsvim
 j9eAvvWn5xPSdw0uYtd/NFSLXsVjS6fNdeV8djU1JpGTi2trj1skgzhII6UbLZS5x3fp
 IXgjGfI2kb4irfOOvVLTElopaLPsh4YKwR1ygIFnERJZvjA0Jp+30REWaGyUW5v9dDBq
 e/TGq3KjC105fT6TZa3whl9RRBUF+ragpQkx25h67Sz8VwisSozH/u1g2Kpt6n1sJfeU Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpem7ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:39:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL3Vmcq031234;
        Tue, 21 Nov 2023 05:39:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6e7df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCOzvvCKzt3DYxlz6biDwSefWH96PaLQ6vzDkW2IFVAB1wQdriq6o7wyi88/cOYwKm6qOWFq2PeRD/ur2AxiuSiltYmKvvFAsSXb05ZwAiV5QOSX+W5+ex5Xs0TqilvFC8yvRP1H8NsYOBoH/F50mkKEWuJbKU5JE4VemuCH+ffDe168Bdzc2Ksw4EB8/uJtq7+Wb7KUSciB5wAftO2/bfaASZl0zibd8MTY63YWgJPrTEiJFBTv18dnsw2UcTQ3FVaKLyT71Ex0UCMqwHZv6sL+ZKjl6sAe6/A3rtf+zBQ6lbaZ6FaR5RpCCnrv/8oecdOPdotwX5EOk9dlF/Liyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytQOJTFfnC0yeIKVZ9M2KR3Rxj00QSeKnZtrv3aXzYw=;
 b=bOSneHFHs8g2VZ674p4oaP52wf7qFC5Yv2fK4wLYFavYINW4JSBiO8mAAtoY7I4BwMsP+aqI5E+TmCsVESGd6Nw0ohXwItLOZj4DMvGwTwSF4BUVaitvLuOMV3GWdrKW2xUKajDQblJE7xfioOv1JO5HweS1DqNz8o+ykVjFIx3ErjtJfg3z7+eyqM8VfmIh/QyQK9I4x6jZk6iwwby1R00XinVvsdgzOy0lJMa3AIU1uyqfDFvNjaYO8XxMFoIWoIo9t986gUJa0I4a9ZPpQ5fKKRAn4+zLyUD/mw3jbsfZu5BY8fwu3M0czX5+Zx5ddJm9nVR7KNqjgzuFkUJwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQOJTFfnC0yeIKVZ9M2KR3Rxj00QSeKnZtrv3aXzYw=;
 b=Vg/ZdoGn/Dlox6yXZdu4+vx/H5YipVwPjWVMWAWLROJUJG/uMZE78G2UfOZT/AbMv+ULDvNEW4uup1ArVMMhfNsVUIbrKR2lfqTny0mXtwVHtb4rqJCTFcI0pZ/XroSG7uVIkJtG8l7lr6SQbIVGrk1ZtJslccyt3oHtfbySqBE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5378.namprd10.prod.outlook.com (2603:10b6:208:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 05:39:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:39:17 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-48-ankur.a.arora@oracle.com>
 <20231107192703.1c493431@gandalf.local.home>
 <b8c1ae88-5c12-488c-a7af-42119ebd55d2@paulmck-laptop>
 <20231120224356.7e9e5423@gandalf.local.home>
 <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-reply-to: <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
Date:   Mon, 20 Nov 2023 21:39:14 -0800
Message-ID: <87h6lf1x8d.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:510:324::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f63651-7ddb-4cef-5360-08dbea543400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QycDsNbZw8CimGpgfkyg7jM+C0wE7K2uF3LxjRJmIgKSNVAp+gSzSDsPOR1nQ3lmdaiCO+amheW8DX5TiLVSpF/NO9VECr+EbF4YaEoZu4pzEtLsx9HVy1XsXCftQ3YIZeRonWqPpeE8oChVHymlXty4qEA5m2T+FKaSszbiECoPBuxFksOHDSosQz7n8Zrt7mNoq73tAeWA1zswEFFkjhiTCHa0fZFgz7xBkoOkr5V4VCG70eNlbAFS/hnyN4XYoZLayd5Zfi0bDsxnw0ObWME8U2eiEA6thDM4lluHHKdu5ycyT/NPnUYEQnZabes0Is7yeiksg9UaT8Gkf4U1bXq9fggHAyxplWYVcDFjxIDjqscaOKac/D6GBKumJqztocIniQZPQibjF/KQnnwoaIe3RC5IurUeo804VqzmQW8EGtl+57QWgUyaXmfNGpAPi5wxdYtZjVEQ+pD/f0yWqjExkmT+GVxcmb/l7etVnls5bmtRpOvtLwNPhC8SRIUKve1JC3FehTY5Qutt0r3Z6r/J+xJVbX7mUZQhoWTg8WNWcJfPOae0HbcvNGeuvAyr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6506007)(26005)(6486002)(6512007)(6666004)(54906003)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(8936002)(38100700002)(4326008)(8676002)(5660300002)(7406005)(7416002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDKryXGcHC/bCCdVMPrUVhOP+OQumBu88aAu5Jrmx1o0/gKSSO4gIXeWhDA+?=
 =?us-ascii?Q?u1C3kMClQzQak2CNIwPa9V7dHqBNeSbbMczv8ttlK4Hj+UeVWmMciWXsPyqd?=
 =?us-ascii?Q?vi+uptHxiSAstbWNDIERUMhCmDuCgE3wuu7nDPagJ6oR46sQZE7YQypDzw91?=
 =?us-ascii?Q?7Sz2XA0i2W3r98z9HuhCS28C+7Ald4KUbf0wYTdufj8i4NR2GlppKKzLIXBu?=
 =?us-ascii?Q?5jvZT/5FxCp2NJubBwYg0VuxbARPRxNbcdKqaGvKE/1xu3bYU0u8/Z05Dd9D?=
 =?us-ascii?Q?QYNLWryQDCVy538xksJuoYfJXVcl+EjpwEzRIKLuzuedrVks0pvt8sp064+v?=
 =?us-ascii?Q?r6FcRITx2QOZwK4fKo5sshSK+j461es07hncYCK0gbkTMNUwtvR4PAkrVfz2?=
 =?us-ascii?Q?LWo2pwpifPWgBTSyDAWBpyPEpZ+q1GFPGItPmGSDLhfnVYpUGfd4JGaVN428?=
 =?us-ascii?Q?tsvRgoB5O+LnjqtSFEJGlvkzF2ce1SJnIGxQsK6EVSlFM59Oe5f4lD5hobgq?=
 =?us-ascii?Q?T/ErBmJOThbFXYFY5e0KTQ6ydMliSgRKjEcwIH4r49kzTOcqO3Uf4THuioe7?=
 =?us-ascii?Q?GcKYVb4lTDuaTc4rGAqTeZez/+bWwc3SR818cjZsrEq6L3ci6o88UE3CohoL?=
 =?us-ascii?Q?G/t29pOg/wGrkMaR+GSSPs3hbmsbIXDrS2eBRqnw7W71Ln5RZkBe78YktLNT?=
 =?us-ascii?Q?n62TwT+IlcBquLXjWJXwg1Re8y9+SrREa1UexyjvEPoE+WIdGnQd0+BgLFww?=
 =?us-ascii?Q?VAcZOiG5i4HfXqhh0I4F/WHnHjDHlShSTyuLtXisHsgqp81zhW1js9d/u4cQ?=
 =?us-ascii?Q?iLOFH08sN9vR/fWdxPSI8K1646e+kfUFjNWyOhdrLefezZGjmIipIIL3W6/S?=
 =?us-ascii?Q?UVo/RSZaBeXsWXqEsozGPUkuMGz26u48q31Fi5//v3nhF7C5Je2BkVzSYnOX?=
 =?us-ascii?Q?+fUiJCPMnHs1Edu5gVjCdCaGIvKNyNDG6sfkRV0wqUkc6Yhua6+RRjyrfwZS?=
 =?us-ascii?Q?s0kV1ObFVfvf23hc0IAZ35UIxm/TmdwvUn6q0h2PTQDyb3Jza7e3a1VhhQPz?=
 =?us-ascii?Q?vuoZr9xsKr/Dgz1IZzusMRzFTRHdAnO+jyFDWLMj/wDE2kDx3v90TgnxRX6B?=
 =?us-ascii?Q?1bOlhjbo03ODDqcI9gjEUadl67lusFLO9tXWObY9l/a9GXC73CycOc1TcGR2?=
 =?us-ascii?Q?OUnQYH181ns2lqDnHQ0HAGojohBBFse0rNfuJdWnhjH2JXYEqUk6yJxonhdi?=
 =?us-ascii?Q?CEJ2QqP4vwCQ+1RwF2NpxhyBraU4t1SJ02dtTGAXv2TAE3kFwuwQIhrH421G?=
 =?us-ascii?Q?sIU4cPMro4PFUTdIkQQWUJuf+5yZt/ieOUBzyyqR1Im08sUNuLG4C5yp1Apn?=
 =?us-ascii?Q?bmrhQDaO7tkoRwvwm+GnxNwt36N6WtRmgJg9tE8eK5dz6cm2i94LIcGAl3MM?=
 =?us-ascii?Q?pb7Qqi8iBW6uRkCILi/jNjZzqvxI5PFvuaYNDvUIa8luV4J5smZnKgUM11H+?=
 =?us-ascii?Q?n7RkRB1Wc9x/7e72g4PWIdcR5YIEg593KNb1hlN/2q75zOA7cSvnI5lI4oCa?=
 =?us-ascii?Q?3MkX3zOc8Td5vatnD5hb0tdnUI6BIXMvobs/Yhy0XPZnXQPMvFmJUZjN3TkL?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hF/D/gQMWfqEYsmp3cRIrz+XJ+4SS+8aMZevQGaYrsutWuFnfkwp5z2Wpc7z?=
 =?us-ascii?Q?xvepuGtFPdkQfzh8AKCIUX4/nu8/qWPYBv9pFki6E3DapJLiQ+3JdCgPqWkc?=
 =?us-ascii?Q?vR6mcLYENfKg7S+ohG2ePC7hvCcNCJ07d+xVnT8ZUzC7lHZTAARLqEgLX626?=
 =?us-ascii?Q?p5VShvy9XE9oDlZw02xdpahGt9OS3yOmmTp7U+SAeTGW3QJYvN5bDyh/FXDI?=
 =?us-ascii?Q?XhiDoOMoSZXYVsvw2Gb402LF/l1GDaEyVvOc2SM+w59ekGdHHx6mwEXglga5?=
 =?us-ascii?Q?/TGg+ja8l2ZY5BuPHAyrs5pGrImxyVkSwa5FEY47V+Lo/HD2OTTnHB4zVN/1?=
 =?us-ascii?Q?aj8jq8EKMZFYZVfng1QYHuFWNazrcehnFFVWL8x0mPkoWL2h8KrPmefCThkj?=
 =?us-ascii?Q?Dns8nGOfvNiJSeo7MFQeZTHiYVXvDg61L0Kqz623xMkhaHRE5UlYo5l2zVNA?=
 =?us-ascii?Q?hVJl8sQfaNuX/no/Br/+ARa/3YoSLV0YCVAUoH04lgYFgG9Dm4lzV44OBL0o?=
 =?us-ascii?Q?lfY2dauMDm+NP4qloLblCL90qHI+Hw6pVDeHV/q+t7OTXcEQ+6wjcA1mD/mM?=
 =?us-ascii?Q?5m3Qttr1DvZ9AnYcUzlBGIXO9IvQfTU8IimMiNi2UGD834XZP9MLWaoFxeMW?=
 =?us-ascii?Q?fw9DjaSznvo+5Y5p3ulVNbcxB++Yf3cbd/KRvX+ZKmqdCNYR0jcujmFwUCiI?=
 =?us-ascii?Q?Y9rx9TqiiBVAThrzUjdJHwnSn4IAk7WJ84EseG6k4aGdkiLq5s/ai9xIhBjT?=
 =?us-ascii?Q?PfJYIyvxSV6pelK0HwejNpp0ojt5KKe851NO/KV4iIYf4r5ckLj2vPv9iNXC?=
 =?us-ascii?Q?Lk5ULplSHVlhDvh+fHh56etHluKv2ugzkZvb38K75HJcOJe0M5F/C3DVNa0W?=
 =?us-ascii?Q?HEiLLCcAU8k4nuDfuWOJfc7Pvmyr002fg+277q0Ttjsmn4TNTrEVt0lA4/Xp?=
 =?us-ascii?Q?pN82IvACgxm9V5hI9WrQo69a4OLcJ+gGreW1F8m9oS6Im+AvEceHZnmJQqjp?=
 =?us-ascii?Q?magn66vhiJ6b6QCb8I1ieCPnciZWyD5OHQmX15v3eGRYLrxjeq/3NRRJmcFW?=
 =?us-ascii?Q?JdymDzizkX8JnnUlluIoNdOYLpOR5Q/p4URK06i7pgCiTAe2VLeXlwg/XjKK?=
 =?us-ascii?Q?xMHbHIc1LIFe/d+lYerlCWvsz7tzxLLQVIwyh13Tn5vjbkPZOgJ5OdjvuTPO?=
 =?us-ascii?Q?+811w4bmlch4MGZrSZmKE9TvciT2oaqk/BCTVgUciB9YMapWaBiiTz9Rtmcr?=
 =?us-ascii?Q?Xeajf1Os2H/TI5SKsKdehaRdw/Upt9VlWs+HpqVsuKPRMd7xCRSQ+ACCXMXf?=
 =?us-ascii?Q?QwLd38AEJSSgb1OoK0mTYGApv1KaZqJj2IUrD/MGAaHpFaiL70SKwsDBTtd6?=
 =?us-ascii?Q?FNBqeux3g82oOYBUSXPQcf7/XovQvMCS6nhyMn2C53xVbJpK1fjTCauwZ0/H?=
 =?us-ascii?Q?Tz7WDxQ3Xlr7/HeR1W6BFRLXwpTb2jc1H54Lt2TrlMPZLhh4yqM7BbY495YC?=
 =?us-ascii?Q?+pdV9MJsUM1Rb8xmfp/diqZiQI2/LP30hb+XSGgeCwGyWL9yBHPuNPkR+ze0?=
 =?us-ascii?Q?X5xLFMpmMPL0suHuL001U5fQzQ/n7qW1MOUX3xEz1sX2W9wD5c8KsJbfeart?=
 =?us-ascii?Q?bdGEwZtCdpFjorsxmGj8HFs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f63651-7ddb-4cef-5360-08dbea543400
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:39:17.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WB6CJmk4J3Si/hAIBHgu7jN5XPAedWv75OebzDQkOXtt81KJwrwcNamUBX34asqRnyreV17hXlAbGbEZcH6LrNcqAO7oOA3Y+aFNgXg2eNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=963 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210042
X-Proofpoint-GUID: _RIltzUHezDSTJUnnrzvU8kNCw_Gjh--
X-Proofpoint-ORIG-GUID: _RIltzUHezDSTJUnnrzvU8kNCw_Gjh--
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Mon, Nov 20, 2023 at 10:43:56PM -0500, Steven Rostedt wrote:
>> On Mon, 20 Nov 2023 16:28:50 -0800
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>
>> > On Tue, Nov 07, 2023 at 07:27:03PM -0500, Steven Rostedt wrote:
>> > > On Tue,  7 Nov 2023 13:57:33 -0800
>> > > Ankur Arora <ankur.a.arora@oracle.com> wrote:
>> > >
>> With the new preemption model, NONE, VOLUNTARY and PREEMPT are now going to
>> determine when NEED_RESCHED is set as supposed to NEED_RESCHED_LAZY. As
>> NEED_RESCHED_LAZY only schedules at kernel / user space transaction, and
>> NEED_RESCHED will schedule when possible (non-preempt disable section).
>
> So NONE really is still supposed to be there.  ;-)
>
>>  Key: L - NEED_RESCHED_LAZY - schedule only at kernel/user boundary
>>       N - NEED_RESCHED - schedule whenever possible (like PREEMPT does today)
>>
>> 			SCHED_OTHER	REAL-TIME/DL
>> 			  Schedule	  Schedule
>>
>> NONE:		      L		     L
>>
>> VOLUNTARY:		      L		     N
>>
>> PREEMPT:		      N		     N
>>
>>
>> So on NONE, NEED_RESCHED_LAZY is set only on scheduling SCHED_OTHER and RT.
>> Which means, it will not schedule until it goes into user space (*).
>>
>> On VOLUNTARY, NEED_RESCHED is set on RT/DL tasks, and LAZY on SCHED_OTHER.
>> So that RT and DL get scheduled just like PREEMPT does today.
>>
>> On PREEMPT, NEED_RESCHED is always set on all scheduling.
>>
>> (*) - caveat - After the next tick, if NEED_RESCHED_LAZY is set, then
>> NEED_RESCHED will be set and the kernel will schedule at the next available
>> moment, this is true for all three models!
>
> OK, so I see that this is now a SCHED_FEAT, and is initialized based
> on CONFIG_PREEMPT_* in kernel/sched/feature.h.  Huh.  OK, we can still
> control this at build time, which is fine.  I don't see how to set it
> at boot time, only at build time or from debugfs.  I will let those who
> want to set this at boot time complain, should they choose to do so.

Needless to say, these patches were just an RFC and so they both overreach
and also miss out things.

v1 adds a new preemption model which coexists with the current
CONFIG_PREEMPT_* and is broadly based on Thomas' PoC and is on the lines
we have been discussing.

>> There may be more details to work out, but the above is basically the gist
>> of the idea. Now, what do you want to do with RCU_PREEMPT? At run time, we
>> can go from NONE to PREEMPT full! But there may be use cases that do not
>> want the overhead of always having RCU_PREEMPT, and will want RCU to be a
>> preempt_disable() section no matter what.
>
> Understood, actually.  And as noted in other replies, I am a bit concerned
> about added latencies from too aggressively removing cond_resched().
>
> More testing required.

Yes, agreed.

--
ankur
