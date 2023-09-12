Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4402979C320
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjILCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239748AbjILCk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:40:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6253DFBE1;
        Mon, 11 Sep 2023 19:05:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJl6uX016135;
        Tue, 12 Sep 2023 02:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J0ubFMYn/ecABK+Sero2861mS4WbzNiWavBU67Nhbps=;
 b=Ak/gNuC8GrlUfvshvABqU5GnN/MfY+BSc8YloeeQdmbh5RTWoLC9NNMseEPxsSfK+zsJ
 6UVxd05j9730q4kKyV7DA9qySaaor/joGdOcjPIg9+YplrcHMGro4Ln19reRc3HJqXzn
 VCpwGDywQ4Cr/cXJG19rQh6A7GLITys6VuEN6vkbZienSUuursWQZ4F1xQLjA4/8JoPz
 gx7Wa1rSlEZPsuNEAF2OYsCHKyUtbBpjGZGurtIqS0QpPs6qhuW3fd0ATRdp5LI+av/b
 Qn51Ntfx+yYj+RDyngawcdq7T5Nt/0N0xB/RrsKXSf/xVFxvs+88pKc8AgXkn8i18STS og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1hy8av3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 02:00:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C0twHg014630;
        Tue, 12 Sep 2023 02:00:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5bapmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 02:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCe9yGCOdYSoEKSdfdLev8ThJgSni1Nx0Nk6ayayJY1FJARREHHPXfkeK8keJDqihzxkCPWRjSjCD9P0lW5WJfO11DoOKaUimzHikNzU0KIG5bPr3yCB0jIHobPifUYfXa3pnw3TrFSL3xgKuG9n82kU1H8bQFHZeidZncm05ajuf9QBU6sXKEycAldeysZrSRZWSp2S2wCe+aKg1FmAICFH4HBi8bnMMQeV+JLuyeraFCZeB3b9F+qe0PgU42sVC87bxbQ2iAU1tlNZhSMmeTMiGF/asBJetdpyluTaDWPjYth0iy++VXtulVcVZNV/tY0Sp2W3duY1180rjENQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ubFMYn/ecABK+Sero2861mS4WbzNiWavBU67Nhbps=;
 b=cM8SaLchQAcuOM+tx8V+BGuB7mL24EaBpahxu0DDiiV3OgOFJ+IGf6ZXB5uvUBMiMKS3CHsk+93CPfrHtysQoOzx/Zt9p7Z3z0eP5vuLT16KDoRhqGYDCmXzvkaUBmLn9G8rvBqIpWGcEK306qiFU+AlctBv3WkxxpXyzTKgV1l+wnV0jZFXgbOYX8oQXtSnPMnCyDjbdRpyU0LaAe3igQ5h5Nw9moIpbk3Sgjjc5oqnmB7F0/ORfMHVCy1cxunziFSf4lxPGlENk0u0aRpI3gA/oGdeZSp0pPdFCCzvYO5Ly46TtFVfZKq2Ncxd6HX/HLHOtHOEJMgT17i39vWBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ubFMYn/ecABK+Sero2861mS4WbzNiWavBU67Nhbps=;
 b=Y7T5sv5Ybum9761hGEujFMrQS9zLIB2j5p/CTNlFfydl/VUfBFhLvqoeuy2Jv/vU3oRI+MG7zGbQ30NQMOtBrRMq+egDeGuwQdpJkjzPBQXwJkd16H1OfuiqpbOv6bwUhjK3FvackltuoFo1gKTIHeyDEN9ojfahgiDjVul6NVE=
Received: from DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) by
 CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Tue, 12 Sep
 2023 02:00:27 +0000
Received: from DM6PR10MB4153.namprd10.prod.outlook.com
 ([fe80::b73f:5218:2512:11bb]) by DM6PR10MB4153.namprd10.prod.outlook.com
 ([fe80::b73f:5218:2512:11bb%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 02:00:27 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Topic: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgAA4j4CAAFsjgIAADhYAgAAwIgA=
Date:   Tue, 12 Sep 2023 02:00:27 +0000
Message-ID: <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <20230911.chaeghaeJ4ei@digikod.net>
 <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
In-Reply-To: <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4153:EE_|CH3PR10MB6692:EE_
x-ms-office365-filtering-correlation-id: f5778e05-0071-441e-96c2-08dbb3340909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoM+3FbuqQspeTTcTtCx0eY9bxqBJeV8WkVqHpg34dJTYqCySBfx7x/c+XMOlOEhCs4E1bDkqa/lOtYbr2gnNUFXzAXwVmjrPl6cFtnWuawmoeR5LqlaJimc2CtUKVDeH04Utz21he3QfIqhJSZVIgnA/2RqDpPHAMdEdP1xhUu9Bdz9Vq7yN3Oo3AX4+AxCs9Ek6ALnvRQJiExXU+jhQOLXLaDg7TA2HWLVf3cP2nu+0fs1uUSe/xEMnR7JNM57TBEWiJW/U1ejcOlOQSp29U6lzgjDWiTFH5iofL1i9T6lNPJpFlXqmoy87NvhZMTTxN4Kqn57M2eRQj4iPx2LGgp7awmnC0wj8lj876UsQQC8v2sUEp1layIHyy++Wc5fqVLcI3TeG4PpIfL+juxxl/hMxph+33CmoVeBAHvQ3clvzWFFWTxO5kVvV4rGGkq1pDYSl0OMcZu0/dh57boEZkLrgR/f6QR6rs1rJfK9iPnH2K+GuzQAlm1CAQXzEqCK/Y65pSPHfAZ0NJe1iS6cXjzMlr5Qw6dB5CG7nS2/4SKQ9tGxE7k2aHJalQ/HtrYlgy+RAjyIjV0SikjrSKMF6lH/LrOKiFjyBj+wDp8FH/tnq5+MXm74P5tpm+dpBJjwUarOfRaUZEqd06sN+pjhbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(186009)(1800799009)(451199024)(8676002)(8936002)(33656002)(4326008)(36756003)(26005)(71200400001)(53546011)(6506007)(6486002)(5660300002)(38070700005)(122000001)(86362001)(38100700002)(2906002)(91956017)(83380400001)(66574015)(76116006)(2616005)(66476007)(41300700001)(66556008)(15650500001)(7416002)(6512007)(478600001)(44832011)(54906003)(64756008)(316002)(6916009)(66946007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1dUb21yNFhpei9pdnpmdVFpMXYrTGdxZCtobFN0SzhyMXhmdWRPWlU0TUN4?=
 =?utf-8?B?ZHk4M1JZalRuSDZGTkZxYXdEZ3A4ZWxGYUZIT2RENFJRQVhuTVozWXB0NnBX?=
 =?utf-8?B?all1RDhTa2kyZ0xFb3pVVTFicWtHcHREeDNOdGN6aGxPbVd4V1VaSnBkdXg4?=
 =?utf-8?B?MVJrN3FVZkVxVkRLblJiOGdxait2QWhXOVpiRGp1bGMySnVBUHcvZjUyYmJC?=
 =?utf-8?B?VXJGUGVzSzBkaW9FeG5helBFRjhqbitxaHQ3YWpUVmgweFpkRmVEeVZWZXdF?=
 =?utf-8?B?OHhGU0RybUY4dEs2NnhkcnEvRWxBWWlHSktDd2hJb3pHSGJ5Z2pVTk43SExu?=
 =?utf-8?B?eFJiYXN5VDVWd2tMTDFmMkxHUVJEeDdtNW0rSk5kek5jMFN0ak5GR0xqZHNM?=
 =?utf-8?B?QkI2cGViMUszOFVmVW1MRnFoTzVXVm5Eczh1TzlTSzVMNk5kZVF1NENtOXd2?=
 =?utf-8?B?UnpqUXd5N0JnOXRlMFFXR3h4ZWtGM0ZCTDRJUitKUklVeGtXVzljRVQraDJE?=
 =?utf-8?B?WTUyR21qQ1c5MU1VWFpEcVIzL05LMnVCbEFNN3NQNHJaazJTR3N1R1lPNUJW?=
 =?utf-8?B?b05yWm8vWklwdkhVUlZVS01zWlZGSUlBV0Z1SWJadXcvUHVrWHpVT0VlSnBN?=
 =?utf-8?B?ZEdzeWhuL3M5SXZDN2kzaGtkL2VzdnBPNWZWVnBQTTk0c0l2aE01Q2I5d1pW?=
 =?utf-8?B?bzFIZ0Y2ZHBBRUtkeVNONEpTbDAxb1BXV3JQVExvUDhiZkVjNnVLK2NmOUl6?=
 =?utf-8?B?ZEJPc2RRS1R0UlRUVlRDRHhiQ1cxNkEvcTkrcDlNMVVrSHVydHpzMnNYeUVJ?=
 =?utf-8?B?cWVGSC9MQXRrSC85TlVOV0s0NVY5QmhENmhocDFtZWtydmlrbGVNUjE1WU1P?=
 =?utf-8?B?UTFLb2dwMTFxMFlkQXdYZHhzbVNYYXlvMUlvMFkyc2oxRUZqSm1CaFBpSzVI?=
 =?utf-8?B?TG1BMU1UcFdvT3pPRmM2KzNLMGhLVSt2Mkkva0NIc0FpVnAwSjlxam1wRllz?=
 =?utf-8?B?UzN6TlRrc2hQVGV6N3diUTRTR1p5eldieXJtTDBxSTB6UkQ2WS84U2FPdXoy?=
 =?utf-8?B?d2Y1OUxBQkVDQjdTbG44a0NUTWZQS2pFWEtpS1lFMFUxOHNvbFFuSzQvZEJF?=
 =?utf-8?B?a0RuNTV2OEhoWGJNUmZKYUNGZ3N2ZHI5SGo0MnUxVVNuVzNUM1RpVG5SVWM1?=
 =?utf-8?B?YzRJb1p2OHFoV0JlV3cwekpSTG1UclpnczdvemxzR2hHaUpJa2pFc0lBMmhr?=
 =?utf-8?B?cFVmRVJTTmgzTFNmei9CWEl1ZDhJNXk0MHUyK1kzVW45eVFKSWJkV2FCV3BC?=
 =?utf-8?B?aGlCVWFBT25VMWlrYjJQZzRadnM1Uk1IQzFZckNRSWErZllZV29TMmdoSXdH?=
 =?utf-8?B?RmZyR2ZucER2S3BBVjZNcm0ySWdKcS9rS0FaSE5PeHZYelA1d0VXM3RuL0xP?=
 =?utf-8?B?cUdHVVQzZUo0Ym1aVHZsT1NDbFl0WEIrSVZPbkYzMlEvR2k2YUI3L0JCclQw?=
 =?utf-8?B?c3NkN0lvRzhoUldRT3dPQS9EQXdqSHRxdlJNd0J6eVVudVhlS1F0WDJYZWk5?=
 =?utf-8?B?TzZqT0VLa2pDRFg4SGU1am1sSk1VdUttRVdXa2JFWCsvUmpZMUxFazZWRjZE?=
 =?utf-8?B?SWlURGF6bXBubk93V2hJS1RiUTRZRWM3UzVaTE81VkxobFc2YWZsT2FVd282?=
 =?utf-8?B?enQvWlZvM1B1WXFieE5iT0FmK2RYZUY2UWlhdGdYSEMzSG5yMkF1YUxCcnp0?=
 =?utf-8?B?cTZIYkRibXBjYjFHVTVFOGRRcSt1eVFoenVqbHh5UE5wRjNSOW5JYm5UM0p1?=
 =?utf-8?B?NmhHM0JEQ2IrekJNOGlpcVExcXE0S3ZmR0RkLy9HbEVabjIxejJsZ0xaRlJU?=
 =?utf-8?B?QVptSHJtWHY5U3FYTWFzM255YUF6Wm1ZL1hXSTdZNm8rdGY3NXVHeXQzWXFw?=
 =?utf-8?B?NjBFOStDQmlRQmFrRWVjR1NsVVFmRGhlZ1hudjZpdk55Mk5JL2w2YTA3aEJO?=
 =?utf-8?B?M2hIYytaelRLVURsWkNIZHBkM3h1WFFIN1QzcU4rV0tTaGtFUmhTZiszMTdk?=
 =?utf-8?B?b3d0ZDNiREt5c0l5d1F5d2F6QXd1VjIzZUJEd2NkR3BxR1pDeU9hM0Q2Q280?=
 =?utf-8?B?TndRdENWMlBrVnRWcElZcVFsN3JudVoyWTBISEdNcDR4QmplR1k2cktVUUQx?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF9F08E922D034CB0583DD507A20A0B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bitUdWNPeWNZdVpGWmNhSUVjU29mYWFCM29ja2pKc2oreW1nUzVwbzFMNzJz?=
 =?utf-8?B?eGtCMHlmMGRFTDgzQ0FKS3hlck5pYWdQRHV6aVU3MUVaWjZnMTNCcTY5Tzlw?=
 =?utf-8?B?QWtYa21Hc2tRWDIwT1o1S0FmOEduVkFRazJGd2JWcVJqUU56OHpHblpBU1Fi?=
 =?utf-8?B?Y1pUVko1QUxZRStwNGtEVGJnM1R1OVh3N3ZCQ3V3K2xiT0hUVGMzRXR3MGVJ?=
 =?utf-8?B?aGM0MHhBZ3VYajVrL0o4NHN4L1MwbHRTTnVPbTlhUFFMVkwyckMrNG1QYnRZ?=
 =?utf-8?B?RjdyN0ZPc3RIWnpoNVBXc3p0TTZlS3FQZXBPdWs0enhjaisrQjgwdm8yRlQw?=
 =?utf-8?B?NjNwTE9GTjN6THpNa25vanNQenFVYkd1NWFXZ3NLVTBLWU5qdGtYNHJKNUFR?=
 =?utf-8?B?SnFhdEtkTW9YNVpIQTQ5Z2w3bU41VE5CSzlUNVVlNGpPVnQ2N0xZdS9zbS92?=
 =?utf-8?B?aTFPTmNnWFZRZ0RvRjY1SFBlNTJDZkc4Sk9nSWpVMkJIVXVPZHFKYmlrT2Fy?=
 =?utf-8?B?aUtPRXpCd3prVzR5bE1NWmh0eEpGa0ZVbzYvNTV6SDFIM2JzRHdYWEpGQkc2?=
 =?utf-8?B?K2FQdzgvYnlRT3NxbVRPUCtpTWcrZmp2MDlFSFhiTzZwTjI5SEhlbHNpbkRX?=
 =?utf-8?B?WDkyQWkwWFNnd2QvSUNrVnNsZXhrMnQ4YTJNMzhUKzFYOXpWUGs4dnE4Tzdx?=
 =?utf-8?B?dWRBTFRlL0VqeUltbWRIRmszRm53cWxUYUlqZm1vbHdVV0NFUElTTEdvVGRV?=
 =?utf-8?B?Sk9ZRFZSb090bDZERFQ3VlhSNEtyVjUxVmU0QVd0Z2x0S1VjbFc0STF1WEd4?=
 =?utf-8?B?MzZ6RFVobUx6ZHM4YXdaeWtKdnYvRDNWYWhWdDdXS1diTE9FYWJyVndNSzRx?=
 =?utf-8?B?Q1RSNTlHa2x3aVZUUzNibEpyckxMb0NsK1h3aVVvMklUTkk5eWYzRXBaMDlt?=
 =?utf-8?B?dlRKVy9qdlVRcDBBMTJvVDN4bXM2N3A1TllVT081ejZBUXVYaHpXSlRzd1Ny?=
 =?utf-8?B?ODdHcDhkaysxZURuNDJ5SENKZ2lremFqaW5NdFV1QnZxQnNIT1J2cDFJYUZG?=
 =?utf-8?B?cTQvbVVmc3ZpMzFEUXI5dkRmVlRRRm84bTQrc2gvcmpOemRXdkFZTi94cXAr?=
 =?utf-8?B?VEI0TWlQQWc0Ti91bGJpcFdGMWg0WkY4OEZYQS9LdFFOMVVhaXJ2Qi9NM2tP?=
 =?utf-8?B?NTRzczViQXprUW5YV0o3SFViU2k5QytITFdCS21tMUZoUlZIb1BJekxCS0Fj?=
 =?utf-8?B?ZWNwYy9WU1lPUXMvRUxqWUdtQ2FsaGdFRTZlTk15YzA2N1V0S1hBVWtSQTFM?=
 =?utf-8?B?TDlXN0xucmFHY2JzQnhYSVI5c2FHNEdPUzdpdkZZM2gvMVhpQWFsZGNzbkpo?=
 =?utf-8?B?KzVPVW92MTYwNVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5778e05-0071-441e-96c2-08dbb3340909
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 02:00:27.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq8lKAJ5+rjXNwipdVEEZc9qgb2IMCqZW4wagfdRWA5L9/eFetQNiy1SzVUI2gDfZ+lgHlUqdqSlQx5b2ljPdD+l9TLawqXxgi+wtzPtMxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120015
X-Proofpoint-GUID: 7UWqnTIMtBGooeDTMjFim99KvkDaeNkw
X-Proofpoint-ORIG-GUID: 7UWqnTIMtBGooeDTMjFim99KvkDaeNkw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDExLCAyMDIzLCBhdCA1OjA4IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjAyMy0wOS0xMSBhdCAyMjoxNyArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIFNlcCAxMSwgMjAyMywgYXQgMTA6
NTEgQU0sIE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4gd3JvdGU6DQo+Pj4gDQo+
Pj4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgMDk6Mjk6MDdBTSAtMDQwMCwgTWltaSBab2hhciB3
cm90ZToNCj4+Pj4gSGkgRXJpYywNCj4+Pj4gDQo+Pj4+IE9uIEZyaSwgMjAyMy0wOS0wOCBhdCAx
NzozNCAtMDQwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+IEN1cnJlbnRseSByb290IGNh
biBkeW5hbWljYWxseSB1cGRhdGUgdGhlIGJsYWNrbGlzdCBrZXlyaW5nIGlmIHRoZSBoYXNoDQo+
Pj4+PiBiZWluZyBhZGRlZCBpcyBzaWduZWQgYW5kIHZvdWNoZWQgZm9yIGJ5IHRoZSBidWlsdGlu
IHRydXN0ZWQga2V5cmluZy4NCj4+Pj4+IEN1cnJlbnRseSBrZXlzIGluIHRoZSBzZWNvbmRhcnkg
dHJ1c3RlZCBrZXlyaW5nIGNhbiBub3QgYmUgdXNlZC4NCj4+Pj4+IA0KPj4+Pj4gS2V5cyB3aXRo
aW4gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FycnkgdGhlIHNhbWUgY2FwYWJpbGl0
aWVzIGFzDQo+Pj4+PiB0aGUgYnVpbHRpbiB0cnVzdGVkIGtleXJpbmcuICBSZWxheCB0aGUgY3Vy
cmVudCByZXN0cmljdGlvbiBmb3IgdXBkYXRpbmcNCj4+Pj4+IHRoZSAuYmxhY2tsaXN0IGtleXJp
bmcgYW5kIGFsbG93IHRoZSBzZWNvbmRhcnkgdG8gYWxzbyBiZSByZWZlcmVuY2VkIGFzDQo+Pj4+
PiBhIHRydXN0IHNvdXJjZS4gIFNpbmNlIHRoZSBtYWNoaW5lIGtleXJpbmcgaXMgbGlua2VkIHRv
IHRoZSBzZWNvbmRhcnkNCj4+Pj4+IHRydXN0ZWQga2V5cmluZywgYW55IGtleSB3aXRoaW4gaXQg
bWF5IGFsc28gYmUgdXNlZC4NCj4+Pj4+IA0KPj4+Pj4gQW4gZXhhbXBsZSB1c2UgY2FzZSBmb3Ig
dGhpcyBpcyBJTUEgYXBwcmFpc2FsLiAgTm93IHRoYXQgSU1BIGJvdGgNCj4+Pj4+IHJlZmVyZW5j
ZXMgdGhlIGJsYWNrbGlzdCBrZXlyaW5nIGFuZCBhbGxvd3MgdGhlIG1hY2hpbmUgb3duZXIgdG8g
YWRkDQo+Pj4+PiBjdXN0b20gSU1BIENBIGNlcnRzIHZpYSB0aGUgbWFjaGluZSBrZXlyaW5nLCB0
aGlzIGFkZHMgdGhlIGFkZGl0aW9uYWwNCj4+Pj4+IGNhcGFiaWxpdHkgZm9yIHRoZSBtYWNoaW5l
IG93bmVyIHRvIGFsc28gZG8gcmV2b2NhdGlvbnMgb24gYSBydW5uaW5nDQo+Pj4+PiBzeXN0ZW0u
DQo+Pj4+PiANCj4+Pj4+IElNQSBhcHByYWlzYWwgdXNhZ2UgZXhhbXBsZSB0byBhZGQgYSByZXZv
Y2F0aW9uIGZvciAvdXNyL2ZvbzoNCj4+Pj4+IA0KPj4+Pj4gc2hhMjU2c3VtIC9iaW4vZm9vIHwg
YXdrICd7cHJpbnRmICJiaW46IiAkMX0nID4gaGFzaC50eHQNCj4+Pj4+IA0KPj4+Pj4gb3BlbnNz
bCBzbWltZSAtc2lnbiAtaW4gaGFzaC50eHQgLWlua2V5IG1hY2hpbmUtcHJpdmF0ZS1rZXkucGVt
IFwNCj4+Pj4+ICAgICAgLXNpZ25lciBtYWNoaW5lLWNlcnRpZmljYXRlLnBlbSAtbm9hdHRyIC1i
aW5hcnkgLW91dGZvcm0gREVSIFwNCj4+Pj4+ICAgICAgLW91dCBoYXNoLnA3cw0KPj4+Pj4gDQo+
Pj4+PiBrZXljdGwgcGFkZCBibGFja2xpc3QgIiQoPCBoYXNoLnR4dCkiICU6LmJsYWNrbGlzdCA8
IGhhc2gucDdzDQo+Pj4+PiANCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVy
aWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+Pj4gDQo+Pj4+IFRoZSBzZWNvbmRhcnkga2V5cmlu
ZyBtYXkgaW5jbHVkZSBib3RoIENBIGFuZCBjb2RlIHNpZ25pbmcga2V5cy4gIFdpdGgNCj4+Pj4g
dGhpcyBjaGFuZ2UgYW55IGtleSBsb2FkZWQgb250byB0aGUgc2Vjb25kYXJ5IGtleXJpbmcgbWF5
IGJsYWNrbGlzdCBhDQo+Pj4+IGhhc2guICBXb3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8g
bGltaXQgYmxhY2tsaXN0aW5nDQo+Pj4+IGNlcnRpZmljYXRlcy9oYXNoZXMgdG8gYXQgbGVhc3Qg
Q0Ega2V5cz8gDQo+Pj4gDQo+Pj4gU29tZSBvcGVyYXRpb25hbCBjb25zdHJhaW50cyBtYXkgbGlt
aXQgd2hhdCBhIENBIGNhbiBzaWduLg0KPj4gDQo+PiBBZ3JlZWQuICANCj4+IA0KPj4gSXMgdGhl
cmUgcHJlY2VkZW50cyBmb3IgcmVxdWlyaW5nIHRoaXMgUy9NSU1FIHRvIGJlIHNpZ25lZCBieSBh
IENBPyANCj4+IA0KPj4+IFRoaXMgY2hhbmdlIGlzIGNyaXRpY2FsIGFuZCBzaG91bGQgYmUgdGll
ZCB0byBhIGRlZGljYXRlZCBrZXJuZWwgY29uZmlnDQo+Pj4gKGRpc2FibGVkIGJ5IGRlZmF1bHQp
LCBvdGhlcndpc2UgZXhpc3Rpbmcgc3lzdGVtcyB1c2luZyB0aGlzIGZlYXR1cmUNCj4+PiB3aWxs
IGhhdmUgdGhlaXIgdGhyZWF0IG1vZGVsIGF1dG9tYXRpY2FsbHkgY2hhbmdlZCB3aXRob3V0IG5v
dGljZS4NCj4+IA0KPj4gVG9kYXkgd2UgaGF2ZSBJTlRFR1JJVFlfQ0FfTUFDSElORV9LRVlSSU5H
X01BWC4gIFRoaXMgY2FuIA0KPj4gYmUgZW5hYmxlZCB0byBlbmZvcmNlIENBIHJlc3RyaWN0aW9u
cyBvbiB0aGUgbWFjaGluZSBrZXlyaW5nLiAgTWltaSwgd291bGQgDQo+PiB0aGlzIGJlIGEgc3Vp
dGFibGUgc29sdXRpb24gZm9yIHdoYXQgeW91IGFyZSBhZnRlcj8NCj4gDQo+IFRoZXJlIG5lZWRz
IHRvIGJlIHNvbWUgY29ycmVsYXRpb24gYmV0d2VlbiB0aGUgZmlsZSBoYXNoZXMgYmVpbmcgYWRk
ZWQNCj4gdG8gdGhlIGJsYWNrbGlzdCBhbmQgdGhlIGNlcnRpZmljYXRlIHRoYXQgc2lnbmVkIHRo
ZW0uICBXaXRob3V0IHRoYXQNCj4gY29ycmVsYXRpb24sIGFueSBrZXkgb24gdGhlIHNlY29uZGFy
eSB0cnVzdGVkIGtleXJpbmcgY291bGQgYWRkIGFueQ0KPiBmaWxlIGhhc2hlcyBpdCB3YW50cyB0
byB0aGUgYmxhY2tsaXN0Lg0KDQpUb2RheSBhbnkga2V5IGluIHRoZSBzZWNvbmRhcnkgdHJ1c3Rl
ZCBrZXlyaW5nIGNhbiBiZSB1c2VkIHRvIHZhbGlkYXRlIGEgDQpzaWduZWQga2VybmVsIG1vZHVs
ZS4gIEF0IGEgbGF0ZXIgdGltZSwgaWYgYSBuZXcgaGFzaCBpcyBhZGRlZCB0byB0aGUgYmxhY2ts
aXN0IA0Ka2V5cmluZyB0byByZXZva2UgbG9hZGluZyBhIHNpZ25lZCBrZXJuZWwgbW9kdWxlLCAg
dGhlIGFiaWxpdHkgdG8gZG8gdGhlIA0KcmV2b2NhdGlvbiB3aXRoIHRoaXMgYWRkaXRpb25hbCBj
aGFuZ2Ugd291bGQgYmUgbW9yZSByZXN0cmljdGl2ZSB0aGFuIGxvYWRpbmcgDQp0aGUgb3JpZ2lu
YWwgbW9kdWxlLg0KDQpCdXQsIGlmIHlvdSB0aGluayBpdCB3b3VsZCBiZSBhcHByb3ByaWF0ZSwg
SSBjb3VsZCBhZGQgYSBuZXcgS2NvbmZpZyAoZGlzYWJsZWQgDQpieSBkZWZhdWx0KSB0aGF0IHZh
bGlkYXRlcyB0aGUga2V5IGJlaW5nIHVzZWQgdG8gdm91Y2ggdGhlIFMvTUlNRSBlbmNvZGVkIA0K
aGFzaCBpcyBhIENBLiAgVGhhdCB3b3VsZCBjZXJ0YWlubHkgbWFrZSB0aGlzIG1vcmUgY29tcGxp
Y2F0ZWQuICAgV2l0aCB0aGlzIA0KYWRkaXRpb24sIHdvdWxkICB0aGUga2V5IHVzYWdlIGZpZWxk
IG5lZWQgdG8gYmUgcmVmZXJlbmNlZCB0b28/DQoNCkFub3RoZXIgaWRlYSBJIGhhZCB3YXMgY2hh
bmdpbmcgdGhpcyBwYXRjaCB0byByZWZlcmVuY2Ugb25seSB0aGUgYnVpbHRpbiBhbmQgDQp0aGUg
bWFjaGluZSBrZXlyaW5nIChpZiBjb25maWd1cmVkKSwgbm90IHRoZSBzZWNvbmRhcnkga2V5cmlu
Zy4gICBUaGVuIHdpdGgNCklOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkdfTUFYLCBvbmx5IENB
IGtleXMgY291bGQgYmUgDQp1c2VkLiBMZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIG9uIHRoaXMg
YXBwcm9hY2guICBUaGFua3MuDQoNCg==
