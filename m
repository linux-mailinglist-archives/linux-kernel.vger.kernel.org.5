Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B37F99DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjK0Gdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0Gdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:33:44 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62393;
        Sun, 26 Nov 2023 22:33:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igw9aO5LRS25ksgZsPQht2A6ItDeLkzoGWemanRKeijla09Hv6uBj1d/0OsY0ZEDm2Fxhb5hljtfaIpE9Ik0BpGSufFACFeZrIxIcjki/P5gKZK01HTgj/jtQ6gs+NA7qYGDxgavuXgYYAVRnpYH/r+1/H8cVuPlCAedq9xrrPLdmhagD/69pZXhRcb17MQsiYu95FMRyXz456BZEN2m03fdL1zhJ0O0gpgpfg2ZNCIy0OuXnI3kGu0DfclGFAIetwn4YKfPKAkaO/tS72OcpgRdvkgs60c/XVd9r3R6P4x89EmhQKJo3ItTSxDDlmedUi8X3GgaqP83o7G7lcKjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjfXcdzZ3BkIWlvyxw/EJmXSsYRJPOlPGWUo3rW91q0=;
 b=lFRZ6PuPguQbxhdKcHoVUyM1dRQoksbKTIjGEIXPIAW6KtZyF7dxXl7pJng5pvIsAHH1BkQuguH9jYZulqKIuYkMqPFYEGx8/a+R9mJBOTas1nrrMrUvq6Priy0pbpzQuSOb45vr6AlU47CrfMqut0Kb1RvOcy8v3GK6ytW5J+QLtt8wNS739niR3JVXaVZp0eaLbJX9fxovTwdNYZs8MzGWSxSFUU6ms81YLKW7k/RbfS0SucR8hEiXiHpUW6Q1+LjVQW8b/gqPZSCD2/pdJ2Xq4kcFJUkXPF82qaFt6dwN91/YCoe6dys0GkWE4+/x4bpxo7PdiqLxo7BhxUAVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjfXcdzZ3BkIWlvyxw/EJmXSsYRJPOlPGWUo3rW91q0=;
 b=dPdL8TVuSo578Pu4g0uTabceIzKqKk/cnwPV49ny3rAYgoRkKK/82to8KR6DKEnGsZIQG1HqG53W5j/t8OUh0upeDlQQZBjPksbSa0pCXdlJxx1CFH24bwtYpc7e33Y3EFQHvK8WmsghH7wILy+5uv7rQkE8TZYZQo/t4Mq8Sgo=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by DB9PR04MB8236.eurprd04.prod.outlook.com (2603:10a6:10:245::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 06:33:45 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 06:33:44 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf pmu: add loaded_json_aliases for non-core pmu when
 get total events number
Thread-Topic: [PATCH] perf pmu: add loaded_json_aliases for non-core pmu when
 get total events number
Thread-Index: AQHaIPr1j5vK430PdUi1IDNgjX5a+LCNtBVQ
Date:   Mon, 27 Nov 2023 06:33:44 +0000
Message-ID: <DB7PR04MB5146CA5E3126922635E181CC8CBDA@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231127063415.996831-1-xu.yang_2@nxp.com>
In-Reply-To: <20231127063415.996831-1-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|DB9PR04MB8236:EE_
x-ms-office365-filtering-correlation-id: 0b04baa7-beef-402a-b62b-08dbef12ce05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSxPUJtMPXjwjFqlG6S6VfTQlgVS+nALds2xH8jtUIppWSXaO3p1sA3YZefAQqDWbZS/uehts672fZWMMVh4wnh9pd7NzHI2hVzjNiaAC1GGQPxz9eiA3s4ZsTfJ0yp3V3TeSUmHAqE9+yfRzej4eFFn6xNvAsOiQFmqIrMBZwQXUVLmcgxvk9gG5cEq9n/PsBygaSswFSFVvpLSDZELb0nE4MfMbp4bRmeS4UtOuy7uwL2ZB4z41QdUAvvIgHp1m+vjJn059yZNQ4/tfdBsIVbEd9Bm+NNHV4qhEq3CGS7jDTjlE9wGJCvwIOaPk6mAPvuJ8EJBTc12rJEqce3S0u837xoPzOFH6w5op2V1b08a5O2BBFDKGF7eGITmH1cKrqSKFHV2JVwCLnMlhnLP3smLXnydyblJmzOpfqLKbKnqWuV7iw3TNkZOFJXUDJ3DDIzPXeoh6dTCppZml8OHj7t+d6lOfYmAyJjYvuOsRifCrIfR/F7jiGxWubZWSRvPahic4VrNE6ytCTYg8IqcYo9hKZnTEeb4AS/tQvr0NNVrJW9dIcTReDWpo+gIH+1HnKQiMHgffN0vDzzd+r98I+N/sJwYZcSGNaYiIW/9tBI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6506007)(966005)(478600001)(9686003)(7696005)(71200400001)(83380400001)(2906002)(7416002)(41300700001)(5660300002)(66946007)(76116006)(64756008)(66476007)(110136005)(54906003)(66556008)(316002)(66446008)(4326008)(52536014)(8936002)(8676002)(38100700002)(38070700009)(86362001)(122000001)(33656002)(55016003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9tAWmhaRijEih63bTISvwM42AV6/jrKlz29sq5kgLKYPuTuNM3WO1SktqUMl?=
 =?us-ascii?Q?4C1bRXZOk7ZQyc2ya5HvKYg2+RqChzn6u7gV+UODw9+2XId/3kdn8wyvbPII?=
 =?us-ascii?Q?uDKXESq62tkROEHaIhwbUtjneHNXarrRjBkfZImY4G+jHOz7RhzDQAb/RQo4?=
 =?us-ascii?Q?U3ARytJilo/vYd4F/gJtq+/35eZhhPxKA/ZV4/TOyI9NnovDeQzA4fQAkeGV?=
 =?us-ascii?Q?6Xuu61EwFSrcsUbKFNLWpth7it7987T7qoSCogfqZ0VRAZBSE8XugWZa1SRQ?=
 =?us-ascii?Q?bmJQlxGEJkpxKaI9etjPPCkxEGiRxvbd4AbD1xlwP9PwHNcqSwDPzca5nrDL?=
 =?us-ascii?Q?H91iqTU+fFXsLUuW1cngxMCEuAVNyd1Bio/lrgSgiqFhOMO4N1l1zYV2kN19?=
 =?us-ascii?Q?sWXyGRmgEfzBzgrzFXP+zZtoIgZ6FSQdtu6B6rJOeHEQCp5Pvk8FIuih109o?=
 =?us-ascii?Q?71jmfv6rw1eKr1+kLQ3Qj1KdkMLjuSES6F0IpDZC2br4i5BuY59OA8rcRF7A?=
 =?us-ascii?Q?H3OjvuZWzO9XCaZIJungPlTxbPYFc0L6FYshsgApy7Hgms1t9e9ppfNcRxFg?=
 =?us-ascii?Q?Bvm2SEZDSmgxca5t68KZOlDO/Tf8pKUJeWSVwKQffhsGOs8Zq5GN+AuJPTw8?=
 =?us-ascii?Q?aYqIgjyzqZpRjMro82sl0haOdjDTujrAw73GMyv7hxtBxXjnROpju1VBEJ+T?=
 =?us-ascii?Q?kZESyT43B+mAwp5oIjmAdBIQDZvtNupQz27562tcFlaqhWpUawjTXj9ZySlj?=
 =?us-ascii?Q?yZji7y86RxSPvizlYGACUR+6v8nxDWv+/X76v19CrSDMXjQ3hfM5KT9ykUVM?=
 =?us-ascii?Q?0sRUo6796mZWeM/Uzy+goXCJGJLffwxuIbTr66I/gwRzBZD1n77iTIXdkIeY?=
 =?us-ascii?Q?1DgLNw0V6WICtTHxzl3m8VUzgJHdi62fHESkpFc79aPoPW6grU5F8mZUQfKj?=
 =?us-ascii?Q?NMMqVXrEW6XCUITcFKW6ViuX1W6PwAMURE2F1DAkuKUi9YSLUFCbEjVvncFy?=
 =?us-ascii?Q?fk86U6vj1D+8Lx/ehLMFGczmqRZV5pzzkH+6Zl86yA0rnCZBIs+UsufgQD/D?=
 =?us-ascii?Q?toI+h7cwZw4JVEOohGECY/AtzEFeP9ZZCaEhU7vN9cBL2jy9C3UMZXwqoNqr?=
 =?us-ascii?Q?Fv4f1J9pDh3y2PN4K2TQYQUTVH843EhoRjk59JCRSx4rhlzxTTMf5wVeYhBm?=
 =?us-ascii?Q?xCG1nUYxaRuwfzULqHyJ6iU6o3LDfEr2AE798NNJ6NK/jBd+qSNLNL5zp/kM?=
 =?us-ascii?Q?DRdr9MK0csNcnWi1M/SNBKbHcpzqxsNUfTBJd4xjC6P89C5VMOKj6z6KXVZ/?=
 =?us-ascii?Q?/2EwN+WLsW4MR+tUbouxWYalZi7lG2fC2hXOkTEO0nAsvKPZifGYx+l3C2xB?=
 =?us-ascii?Q?z42e9zUcK4eLVJ31VVw+6925YxPdv6erex+TZFtajkpmRs/GT9WWH3l9io0U?=
 =?us-ascii?Q?5IJQl3nVDOO2srlEu8Mb5x7ih1HiCDxcgIorsTZ50mBW5U0JusvA5KXP/cb7?=
 =?us-ascii?Q?yR91fhuuwfLcsx1cn8sfJLiVy6lN3jvXJgEWQ45TGOwLTFKQNfASC9EynjVv?=
 =?us-ascii?Q?gSHLnPSXAsMBLxu4Msw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b04baa7-beef-402a-b62b-08dbef12ce05
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 06:33:44.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJi1B8k7YXA3soDdxdQEHgmgnwseKsUKU+XKTKj+LZswmmxND3Bu1BIr9yEQPoaKe6WOpP4wigbp0Pk2AlYIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8236
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> After pmu_read_sysfs(), event aliases in json may be loaded for non-core
> pmu. And pmu->event_table is NULL for non-core pmu.
> If perf_pmu__num_events() didn't add loaded_json_aliases to the total
> number, perf list will show below error:
>=20
> Unexpected event imx8_ddr0/imx8_ddr0/write-command//
> ...
>=20
> This is because perf_pmu__num_events() didn't count correct events number=
.
> This will allow perf_pmu__num_events() to get corrent events number.

Not sure how, but previous thread about this issue is disconnected.
You can refer to: https://lore.kernel.org/all/20231010065738.2536751-1-xu.y=
ang_2@nxp.com/

Thanks,
Xu Yang

>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  tools/perf/util/pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d3c9aa4326be..646cf3351883 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1631,8 +1631,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>=20
>  	nr =3D pmu->sysfs_aliases;
>=20
> -	if (pmu->cpu_aliases_added)
> -		 nr +=3D pmu->loaded_json_aliases;
> +	if (pmu->cpu_aliases_added || pmu->is_uncore)
> +		nr +=3D pmu->loaded_json_aliases;
>  	else if (pmu->events_table)
>  		nr +=3D pmu_events_table__num_events(pmu->events_table, pmu) - pmu->lo=
aded_json_aliases;
>=20
> --
> 2.34.1

